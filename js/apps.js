$( document ).ready(function(){
  $( document ).on("prowl:load:all prowl:load:orgapps", function(){
    $.simpleGET('/apps', {}, function(data, status, xhr) {
      var apps = xhr.responseJSON;
      $.each(apps, function(index, app) {
        app.envs = [];
        $.simpleGET('/envs', {app_id: app.id}, function(data, status, xhr){
          $.each(xhr.responseJSON, function(index, env) {
            env.deploys = []
            app.envs.push(env);
            $.simpleGET('/deploys', {env_id: env.id}, function(data, status, xhr){
              var deploys = xhr.responseJSON
              env.deploys = deploys;

              if (env.deploys.length > 0) {
                env.lastDeployStatus      = env.deploys[0].status
                env.pendingDeploys        = env.deploys.length
                env.lastDeployDate        = env.deploys[0].updated_at

                switch(env.lastDeployStatus) {
                  case 'finished':
                    env.lastDeployStatusClass = 'success';
                    break;
                  case 'failed':
                    env.lastDeployStatusClass = 'danger';
                    break;
                  case 'pending':
                    env.lastDeployStatusClass = 'info';
                    break;
                  case 'processing':
                    env.lastDeployStatusClass = 'info';
                    break;
                }
              }

              env.pendingDeploys = 0;
              $.each(env.deploys, function(index, deploy){
                if ('pending' == deploy.status) {
                  env.pendingDeploys++;
                }
              });

              $('#apps-col').empty();
              $.loadColumn('apps', apps);
              // console.log(apps);
            });
          });
        });
      });
    });
  });
});
