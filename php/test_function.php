<?php

function add(int $a, int $b): int {
    return $a + $b;
}

function bad_add(int $a, int $b): int {
    return $a - $b;
}