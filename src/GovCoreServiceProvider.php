<?php

namespace Drupal\govcore;

use Drupal\Core\DependencyInjection\ContainerBuilder;
use Drupal\Core\DependencyInjection\ServiceProviderBase;

/**
 * Modifies container services.
 *
 * @internal
 *   This class is a completely internal part of GovCore's uninstall system
 *   and can be changed in any way, or removed outright, at any time without
 *   warning. External code should not use this class in any way.
 */
final class GovCoreServiceProvider extends ServiceProviderBase {

  /**
   * {@inheritdoc}
   */
  public function alter(ContainerBuilder $container) {
    $container->getDefinition('required_module_uninstall_validator')
      ->setClass(RequiredModuleUninstallValidator::class);
  }

}
