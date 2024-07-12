# Dev Box for Accessibility Templates

## What is this Repo?

This repo contains accessibility templates for Dev Boxes so that they can be used to customize your Dev Box at creation time. DSCSamples directory contains different DSC (Desired State Configuration) files in which different customizations are defined. Settings-file directory contains Visual Studio and VSCode settings for accessibility you can use directly and you might replace them with the settings you are currently using so that it is ready for you. workloadSamples directory contains the customization yaml file you could use directly at Dev Box creation in Dev Portal.

## How do I use this repo?

To use this repo, simple follow the steps below with a version of this repo cloned in your local environment.

To create a Dev Box, navigate to the [Microsoft Developer Portal](https://devportal.microsoft.com/)

Click on the `New` Button and choose `New dev box`

![Screenshot of Dev Portal](/devbox-accessibility/media/DevBoxCreation.png)

On the right side there will be a `Add a dev box` form to populate. Add a name and select a project and pool (Project and Pools are populated from what already exist in Dev Center). Choose `Apply customizations` towards the bottom.

![Screenshot of Dev Portal Customization](/devbox-accessibility/media/ApplyCustomization.png)

Click `Add customizations from file` and choose yaml file [BUILDDemo.yaml](/devbox-accessibility/workloadSamples/BUILDDemo.yaml) from this repo

![Screenshot of Customization Validation](/devbox-accessibility/media/Validation.png)

The Dev Portal will validate your customization task and when that is complete, you can create the Dev Box with all the accessibility settings you need. You could also use part of the BUILDDemo.yaml file for accessibility customization that you need.

Your dev box will start to be created and you can see it in Dev Portal

![Screenshot of dev box being created](/devbox-intelligent-apps/media/devbox-creating.png)

You can also see the details of the customization by clicking `See details`

![Screenshot of Customization Details pane](/devbox-accessibility/media/AccessibilityCustomizationDetails.png)

After the Dev Box is created, you can then connect to your Dev Box either via RDP or in the browser.

![Screenshot of Connect with the Remote Desktop Client](/devbox-intelligent-apps/media/connect-to-devbox.png)