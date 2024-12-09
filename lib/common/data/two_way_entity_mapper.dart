typedef TwoWayEntityMapper<Entity, Model> = ({
  Entity Function(Model model) responseMapper,
  Model Function(Entity entity) requestMapper,
});
