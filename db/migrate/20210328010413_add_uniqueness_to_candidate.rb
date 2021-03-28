class AddUniquenessToCandidate < ActiveRecord::Migration[6.1]
  def change
    add_index(:candidates, :cpf, unique: true)
  end
end
