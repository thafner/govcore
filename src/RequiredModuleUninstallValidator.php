<?php

namespace Drupal\govcore;

use Drupal\Core\Extension\RequiredModuleUninstallValidator as BaseValidator;

/**
 * Validates module uninstallation.
 *
 * @internal
 *   This class is a completely internal part of GovCore's uninstall system
 *   and can be changed in any way, or removed outright, at any time without
 *   warning. External code should not use this class in any way.
 */
final class RequiredModuleUninstallValidator extends BaseValidator {

  /**
   * {@inheritdoc}
   */
  protected function getModuleInfoByModule($module) {
    $info = parent::getModuleInfoByModule($module);
    if ($module === 'govcore' || $module === 'headless_govcore') {
      $info['required'] = FALSE;
    }
    return $info;
  }

}
