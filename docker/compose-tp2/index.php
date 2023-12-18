<?php

require_once __DIR__.'/vendor/autoload.php';

$url = 'https://jsonplaceholder.typicode.com/';

$client = new GuzzleHttp\Client([
    'base_uri' => $url,
]);

$response = $client->request('GET', '/todos');

var_dump((string) $response->getBody());
