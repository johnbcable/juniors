<?php
session_start(); 
require_once("twitteroauth.php"); //Path to twitter OAuth routines - in same directory
$twitteruser = "hamptontennis";
$notweets = 30;
$consumerkey = "0oUWODdiyhkrnlQBBodx8Q";
$consumersecret = "NNWDlAsOZU9SDYrDrN6eP74ZS0ZxCrqtVCvQ2c0ls";
$accesstoken = "101008664-pJ97TWTBXRFj1DYbK3LULt74ZLr2MWhaAjkoIPju";
$accesstokensecret = "ya9Ig3F8EjLg2H62imPkpma7uMAJnohpaYElaUDeFYY";
function getConnectionWithAccessToken($cons_key,$cons_secret,$oauth_token,$oauth_token_secret) {
	$connection = new TwitterOAuth($cons_key,$cons_secret,$oauth_token,$oauth_token_secret);
	return $connection;
}
$connection = getConnectionWithAccessToken($consumerkey, $consumersecret, $accesstoken, $accesstokensecret);

$tweets = $connection->get("https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=hamptontennis&count=3");

echo json_encode($tweets);
?>


