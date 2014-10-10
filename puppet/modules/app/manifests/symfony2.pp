import "symfony2/*.pp"

class app::symfony2 {
    include app::symfony2::init

    if $npm {
        include app::symfony2::npm
    }
}
