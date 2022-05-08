#include "blocks/http/api.h"
#include "bricks/dflags/dflags.h"
#include "bricks/sync/waitable_atomic.h"

DEFINE_uint16(port, 8888, "The port to listen on.");

int main(int argc, char** argv) {
  ParseDFlags(&argc, &argv);
  auto& http = HTTP(current::net::BarePort(FLAGS_port));
  HTTPRoutesScope scope;
  scope += http.Register("/add", URLPathArgs::CountMask::Two, [](Request r) {
      r(current::ToString(current::FromString<int>(r.url_path_args[0]) + current::FromString<int>(r.url_path_args[1])) + '\n');
  });
  current::WaitableAtomic<bool> done(false);
  scope += http.Register("/kill", [&done](Request r) {
      r("Terminating.\n");
      *done.MutableScopedAccessor() = true;
  });
  std::cout << "Listening on localhost:" << FLAGS_port << std::endl;
  done.Wait([](bool done) { return done; });
  std::cout << "Terminating." << std::endl;
}
