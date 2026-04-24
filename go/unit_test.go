package main

import "testing"

func TestAddSuccess(t *testing.T) {
	if add(1, 2) != 3 {
		t.Fatalf("expected 3, got %d", add(1, 2))
	}
}

func TestAddFailCase(t *testing.T) {
	if add(1, 2) == -1 {
		t.Fatalf("should not be -1")
	}
}

func TestBadAddFail(t *testing.T) {
	if badAdd(1, 2) != 3 {
		t.Fatalf("expected 3, got %d", badAdd(1, 2))
	}
}

func TestBadAddSuccess(t *testing.T) {
	if badAdd(1, 2) == 3 {
		t.Fatalf("badAdd should not return 3")
	}
}
