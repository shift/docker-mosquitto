@ports
Feature: Ports required to operate
  In order to provide a secure mosquitto installation
  I want to make sure there are only the required ports open.

  Background:
    Given "nmap" is installed

  Scenario: Scan for open ports
    When we scan the site for open ports
    Then we should find only "0" port open
