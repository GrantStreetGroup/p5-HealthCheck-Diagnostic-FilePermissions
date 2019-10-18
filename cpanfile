use GSG::Gitc::CPANfile $_environment;

requires 'HealthCheck::Diagnostic';

test_requires 'Test::Differences';

1;
on develop => sub {
    requires 'Dist::Zilla::PluginBundle::Author::GSG::Internal';
};
