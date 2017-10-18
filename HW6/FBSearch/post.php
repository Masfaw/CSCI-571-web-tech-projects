<?php
include_once("inc.php");
if(isset($_POST["submit"])):
    ?>
    <h3>Thanks for submitting!</h3>
    <pre>
<?php print_array($_POST); ?>
</pre>
<?php endif; ?>
<form method="POST" action="">
    <fieldset>
        <legend>Welcome!</legend>
        <p><label for="first_name">First Name</label>
            <input type="text" name="first_name"
                   value="<?php echo isset($_POST["first_name"]) ?
                       $_POST["first_name"] : "" ?>"></p>
        <p><label for="first_name">Last Name</label>
            <input type="text" name="last_name" value="<?php echo
            isset($_POST["last_name"]) ? $_POST["last_name"] : "" ?>">
        </p>
        <input type="submit" name="submit" value="Submit">
    </fieldset></form>