class RemSudoAuthFromApp < ActiveRecord::Migration
  def up
    dsto = DeployStepTypeOption.find_by name: "has_sudo"
    if dsto
      DeployStep.destroy_all(deploy_step_type_option_id: dsto.id)
      dsto.destroy
    end
    DeployStepType.destroy_all(name: "super_powers")
  end
end
