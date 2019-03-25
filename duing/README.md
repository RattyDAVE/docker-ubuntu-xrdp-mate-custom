# Duing

Docker Ubuntu INstant Gherkin

## What?

An ephemeral environment for BDD testing design with Gherkin

- Start a container with an ubuntu desktop and all the tools to develop BDD Test using Gherkin, like this one

```gherkin
Feature: Google Search to explore BDDfire


Scenario: View home page
Given I am on "http://www.google.com"
When I fill in "q" with the text "bddfire"
Then I should see "Sign in"
```

- Find a ready-to-use ruby library of predefined steps
- Edit the Gherkin features and execute them on Chrome, Firefox and PhantomJS web browsers
- Save screenshots of every test step run

## Credits

Based on:

- Rattydave Ubuntu XRDP and MATE virtual desktop project https://hub.docker.com/r/rattydave/docker-ubuntu-xrdp-mate-custom/
- Shakistan86 BDDFire Instant Cucumber-BDD Framework https://github.com/Shashikant86/bddfire

## How to give a try

Use the Ubuntu Desktop to design your BDD test suite (yes! You have a desktop in a container)

1. Start the container

```console
$ docker run -d --name duing \
           -p 3389:3389 \
           --shm-size 1g \
           -dit --restart unless-stopped \
           kairops/duing
```

2. Access with remote desktop to localhost:3389 with "ubuntu" user and "ubuntu" password

3. Open a terminal and execute the test with PhantomJS, Chrome and Firefox drivers

```console
ubuntu@ce48d033045e:/opt/duingdemo/ci-scripts/test/cucumber$ rake poltergeist
/usr/bin/ruby2.5 -S bundle exec cucumber features -p poltergeist --format pretty --profile html -t ~@api
{"baseurl"=>"https://www.google.es", "take_screenshots"=>true, "screenshot_delay"=>1, "browser_width"=>1024}
Using the poltergeist and html profiles...
Feature: Google Search to explore BDDfire

  Scenario: View home page                     # features/bddfire.feature:4
    Given I am on "http://www.google.com"      # bddfire-2.0.8/lib/bddfire/web/web_steps.rb:2
    When I fill in "q" with the text "bddfire" # bddfire-2.0.8/lib/bddfire/web/web_steps.rb:6
    Then I should see "Sign in"                # bddfire-2.0.8/lib/bddfire/web/web_steps.rb:10

1 scenario (1 passed)
3 steps (3 passed)
0m4.115s
ubuntu@ce48d033045e:/opt/duingdemo/ci-scripts/test/cucumber$ ls -l reports/
total 86
-rw-rw-r-- 1 ubuntu ubuntu 25372 Aug 26 21:06 screenshot_20180826210651_1.png
-rw-rw-r-- 1 ubuntu ubuntu 26741 Aug 26 21:06 screenshot_20180826210651_2.png
-rw-rw-r-- 1 ubuntu ubuntu 26741 Aug 26 21:06 screenshot_20180826210651_3.png
ubuntu@ce48d033045e:/opt/duingdemo/ci-scripts/test/cucumber$ rake chrome

[...]

ubuntu@ce48d033045e:/opt/duingdemo/ci-scripts/test/cucumber$ rake firefox

[...]

```

After each test execution, find screenshots of each step under /opt/duingdemo/ci-scripts/test/cucumber/reports folder

4. Enjoy!

Maybe you want to test without the desktop functionality

1. Create a folder for the screenshots

```console
$ mkdir -m 777 -p reports
```

2. Run the test suite

```console
$ docker run --rm -t -v `pwd`/reports:/opt/duingdemo/ci-scripts/test/cucumber/reports -u ubuntu kairops/duing bash -i -c "cd /opt/duingdemo/ci-scripts/test/cucumber; rake poltergeist"
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

/usr/bin/ruby2.5 -S bundle exec cucumber features -p poltergeist --format pretty --profile html -t ~@api
f{"baseurl"=>"https://www.google.es", "take_screenshots"=>true, "screenshot_delay"=>1, "browser_width"=>1024}
Using the poltergeist and html profiles...
Feature: Google Search to explore BDDfire

  Scenario: View home page                     # features/bddfire.feature:4
    Given I am on "http://www.google.com"      # bddfire-2.0.8/lib/bddfire/web/web_steps.rb:2
    When I fill in "q" with the text "bddfire" # bddfire-2.0.8/lib/bddfire/web/web_steps.rb:6
    Then I should see "Sign in"                # bddfire-2.0.8/lib/bddfire/web/web_steps.rb:10

1 scenario (1 passed)
3 steps (3 passed)
0m4.563s
```

3. Find the screenshots within your `reports` folder

```console
$ ls -ln reports/
total 96
-rw-r--r-- 1 1000 1000 28744 feb 12 07:00 screenshot_20190212060031_1.png
-rw-r--r-- 1 1000 1000 30084 feb 12 07:00 screenshot_20190212060031_2.png
-rw-r--r-- 1 1000 1000 30084 feb 12 07:00 screenshot_20190212060031_3.png
```

And, of course...

4. Enjoy!
