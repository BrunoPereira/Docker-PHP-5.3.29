#!/usr/bin/env php
<?php

$broker = broker_init("127.0.0.1", 3323, SB_TCP, SB_PROTOBUF);
$ret = broker_subscribe_queue($broker, "/sapo/opendisplay/production/externalevents", 0);

$start = time();
$msgs = 0;

// consume without auto-ack
while ($msgs < 500000) {
    $msg = broker_receive($broker, 1000, true);
//    echo "Got message: " . print_r($msg, true) . "\n";
    $msgs++;
}

broker_destroy($broker);
printf("Took %d seconds to consume %d msgs\n", (time()-$start), $msgs);
?>
