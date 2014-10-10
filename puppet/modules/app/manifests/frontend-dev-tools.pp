# Required Frontend Development Tools
class app::frontend-dev-tools {
    package {["npm",
              "nodejs"]:
        ensure => present,
    }
}