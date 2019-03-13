desc 'Update model file schema annotations'
task :annotate do
  sh 'annotate --exclude tests,fixtures,factories,serializers'
end
