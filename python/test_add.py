from main import add, bad_add


def test_add_success():
    assert add(1, 2) == 3
    assert add(-1, 1) == 0
    assert add(0, 0) == 0


def test_add_fail_case():
    assert add(1, 2) != -1


def test_bad_add_should_fail():
    # อันนี้จะ FAIL เหมือน Rust
    assert bad_add(1, 2) == 3