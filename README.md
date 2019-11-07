# NAME

HealthCheck::Diagnostic::FilePermissions - Check the paths for expected permissions in a HealthCheck

# VERSION

version 1.4.0.1

# SYNOPSIS

    use HealthCheck::Diagnostic::FilePermissions;

    # Just check that a file exists, without instantiating anything.
    HealthCheck::Diagnostic::FilePermissions->check(
        files => [ '/tmp', '/other_directory' ],
    );

    # Check that some files have certain permissions.
    my $d = HealthCheck::Diagnostic::FilePermissions->new(
        files => [ '/tmp', '/var/nfs' ],
    );
    $d->check( permissions => 0777 );

    # Check that the app has access to the file(s).
    $d->check( access => 'x' );    # App can execute files.
    $d->check( access => 'rw' );   # App can read and write files.
    $d->check( access => 'r!wx' ); # App can read, not write and execute files.
    $d->check( access => {         # App can read files.
        read => 1,
    } );

    # Check the owner and group of the file.
    $d->check( owner => 'owner_name', group => 'group_name' );

    # Any combination of parameters can be used.
    $d->check(
        permissions => 07777,
        access      => 'rwx',
        owner       => 'dveres',
    );

# DESCRIPTION

This diagnostic allows a process to test file permissions on the system.
You can specify a list of files and then the expected permissions
code for the group.
Additionally, you can specify access permissions for the process that
is running the script.

# ATTRIBUTES

## files

Represents the file names of the files that are checked for the defined
_permissions_.

There are a few forms that this attribute can take up.
The first is a string, which can represent one file path to check.
The value can also be a list of file paths to check.
Finally, this value can also be an anonymous sub and return a list of
file paths to check.

    files => "$filename"
    files => [ $filename1, $filename2 ],
    files => sub { $filename1, 'other_file_name' }

## access

The access permissions of the process executing the code.
This attribute can take two forms, a _HASH_ and `SCALAR`.

The hash form includes _read_, _write_, and _execute_ values, which
represent if the process can perform that action on the file.
Shortcut keys such as _r_, _w_, and _x_ can also be used.

The scalar form is a string that consists of the read/write/execute values
in their short form (Ex: _r_ for _read_, _w_ for _write_, and _x_
for _execute_).
One exclamation point is used to separate the allowed and denied access
on the files.

Any access permissions that are not defined are just ignored.

    # Expect that the app can read, write, and execute the file(s).
    access => 'rwx'
    access => { r    => 1, w     => 1, x       => 1 }
    access => { read => 1, write => 1, execute => 1 },

    # Expect that the app cannot read, write, or execute the file(s).
    access => '!rwx'
    access => { r    => 0, w     => 0, x       => 0 }
    access => { read => 0, write => 0, execute => 0 }

    # Expect that the app can read but not write, nor execute the file(s).
    access => 'r!wx'
    access => { r    => 1, w     => 0, x       => 0 }
    access => { read => 1, write => 0, execute => 0 }

    # Expect that the app can read, but ignore other access permissions.
    access => 'r'
    access => { r    => 1 }
    access => { read => 1 }

## permissions

The octal value of the permissions on the file (or files).

    permissions => 0700 # User can read, write, and execute the file(s).
    permissions => 0000 # Nobody can read, write, or execute the file(s).

## owner

The owner name of the file (or files).

    owner => 'bmessine'
    owner => 'gsgd'

## group

The group name of the file (or files).

    group => 'developers'

# DEPENDENCIES

[HealthCheck::Diagnostic](https://metacpan.org/pod/HealthCheck%3A%3ADiagnostic)

# CONFIGURATION AND ENVIRONMENT

None

# AUTHOR

Grant Street Group <developers@grantstreet.com>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2018 - 2019 by Grant Street Group.  No
license is granted to other entities.

# CONTRIBUTORS

- Authors:
- (9) Brandon Messineo <brandon.messineo@grantstreet.com>
- (2) Andrew Hewus Fresh <andrew.fresh@grantstreet.com>
- (1) Andrew Fresh <andrew.fresh@grantstreet.com>
- Reviewers:
- (2) Andrew Fresh <andrew.fresh@grantstreet.com> 
- (2) Brandon Messineo <brandon.messineo@grantstreet.com> 
- Deployers:
- (12) Brandon Messineo <brandon.messineo@grantstreet.com>  
