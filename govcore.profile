<?php

/**
 * @file
 * The GovCore profile.
 */

use Drupal\user\RoleInterface;

/**
 * Implements hook_install_tasks().
 */
function govcore_install_tasks(array &$install_state) {
  $tasks = [];

  // All of these tasks modify configuration, so don't do any of them if
  // we're installing from existing config.
  if (empty($install_state['config_install_path'])) {
    $tasks['govcore_set_front_page'] = [];
    $tasks['govcore_grant_shortcut_access'] = [];
    $tasks['govcore_set_default_theme'] = [];
    $tasks['govcore_set_logo'] = [];
    $tasks['govcore_alter_frontpage_view'] = [];
  }
  return $tasks;
}

/**
 * Sets the front page path to /node.
 */
function govcore_set_front_page() {
  if (Drupal::moduleHandler()->moduleExists('node')) {
    Drupal::configFactory()
      ->getEditable('system.site')
      ->set('page.front', '/node')
      ->save(TRUE);
  }
}

/**
 * Allows authenticated users to use shortcuts.
 */
function govcore_grant_shortcut_access() {
  if (Drupal::moduleHandler()->moduleExists('shortcut')) {
    user_role_grant_permissions(RoleInterface::AUTHENTICATED_ID, ['access shortcuts']);
  }
}

/**
 * Sets the default and administration themes.
 */
function govcore_set_default_theme() {
  Drupal::configFactory()
    ->getEditable('system.theme')
    ->set('default', 'govcore_theme')
    ->set('admin', 'govcore_theme')
    ->save(TRUE);

  // Use the admin theme for creating content.
  if (Drupal::moduleHandler()->moduleExists('node')) {
    Drupal::configFactory()
      ->getEditable('node.settings')
      ->set('use_admin_theme', TRUE)
      ->save(TRUE);
  }
}

/**
 * Set the path to the logo, favicon and README file based on install directory.
 */
function govcore_set_logo() {
  $govcore_path = drupal_get_path('profile', 'govcore');

  Drupal::configFactory()
    ->getEditable('system.theme.global')
    ->set('logo', [
      'path' => $govcore_path . '/govcore.png',
      'url' => '',
      'use_default' => FALSE,
    ])
    ->set('favicon', [
      'mimetype' => 'image/vnd.microsoft.icon',
      'path' => $govcore_path . '/favicon.ico',
      'url' => '',
      'use_default' => FALSE,
    ])
    ->save(TRUE);
}

/**
 * Alters the frontpage view, if it exists.
 */
function govcore_alter_frontpage_view() {
  $front_page = Drupal::configFactory()->getEditable('views.view.frontpage');

  if (!$front_page->isNew()) {
    $section = 'display.default.display_options.empty.area_text_custom';
    $front_page
      ->set("$section.tokenize", TRUE)
      ->set("$section.content", '<p>Welcome to [site:name]. No front page content has been created yet.</p><p>Would you like to <a href="/' . drupal_get_path('profile', 'govcore') . '/README.md">view the README</a>?</p>')
      ->save(TRUE);
  }
}
