<?php if($_GET["submit"]): ?>
    <HTML><HEAD><TITLE>Query Results</TITLE></HEAD><BODY>
    Query Results<pre>
<?php
foreach($_GET as $key => $value) {
    if ($key !== "submit") {
        echo $key . " = " . $value . "\n";
    }
}
?>
</pre></BODY></HTML>
<?php else: ?>
    <HTML><HEAD><TITLE>Sample Form</TITLE></HEAD><BODY>
    <H1>Application for a Credit Card</H1>
    <FORM METHOD="GET" ACTION="">
        <H4>Background Information</H4>
        Name <INPUT name=name> Street <INPUT name=street><BR>
        City <INPUT name=city> State <SELECT name=state>
            <OPTION> Alabama <OPTION> California <OPTION> New York<OPTION> Wisconsin </SELECT>
        <H4>Amount of Credit</H4> <INPUT type=radio name=amount value=5000>$5,000
        <INPUT type=radio name=amount value=10000>$10,000
        <INPUT type=radio name=amount value=15000>$15,000
        <H4>Financial Facts:</H4> <INPUT type=checkbox name=home>Own a home
        <INPUT type=checkbox name=boat>Own a boat
        <INPUT type=checkbox name=car>Own a car<BR>
        <TEXTAREA rows=5 cols=50 name=family>
Please describe here the names and ages of people in your family and the number of cards
you are requesting. </TEXTAREA>
        <INPUT type=submit name="submit" value="search"> <INPUT type=reset></FORM></BODY>
    </HTML>
<?php endif; ?>