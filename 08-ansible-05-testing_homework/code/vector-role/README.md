Vector
=========

This role can install vector.

Role Variables
--------------

| vars | description |
|------|-------------|
| vector_version | product version vector |
| vector_path | installation directory |
| vector_config | vector config file |
| allow_world_readable_tmpfiles | ansible root user |

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }

License
-------

MIT

Author Information
------------------

Anikeev Ilya.
