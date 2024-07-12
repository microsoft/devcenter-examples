# Dev Box for Accessibility Templates

## What is this Repo?

This repo contains accessibility templates for Dev Boxes so that they can be used to customize your Dev Box at creation time. DSCSamples directory contains different DSC (Desired State Configuration) files in which different customizations are defined. Settings-file directory contains Visual Studio and VSCode settings for accessibility you can use directly and you might replace them with the settings you are currently using so that it is ready for you. workloadSamples directory contains the customization yaml file you could use directly at Dev Box creation in Dev Portal.

## How do I use this repo?

To use this repo, simple follow the steps below with a version of this repo cloned in your local environment.

To create a Dev Box, navigate to the [Microsoft Developer Portal](https://devportal.microsoft.com/)

Click on the `New` Button and choose `New dev box`
![Screenshot of Dev Portal](/devbox-accessibility/media/DevBoxCreation.png)

On the right side there will be a `Add a dev box` form to populate. Add a name and select a project (project is populated from projects that exist in Dev Center)

![Screenshot of Dev Portal Add a dev box pane](/devbox-intelligent-apps/media/add-devbox-empty.png)

- Select a Dev Box pool (defined in project that was selected)

![Screenshot of Add a dev box pane with populated Dev box pool](/devbox-intelligent-apps/media/new-devbox-populated.png)

- From here, you can provide a customization file in 1 of 2 ways
  - Provide a repository that contains your customization file ([Read here](https://techcommunity.microsoft.com/t5/microsoft-developer-community/accelerate-developer-onboarding-with-the-configuration-as-code/ba-p/4062416) to learn more)
  - Upload a customization file (this tutorial follows this process)

- Click `Add customizations from file` and choose yaml file [devbox.yaml](/devbox.yaml) from this repo
- The Dev Portal will validate your customization task and when that is complete, you can create the Dev Box

![Screenshot of Add a dev box pane with customization validation circled in red](/devbox-intelligent-apps/media/valid-customizations.png)

- Your dev box will start to be created and you can see it in Dev Portal

![Screenshot of dev box being created](/devbox-intelligent-apps/media/devbox-creating.png)

- You can also see the details of the customization by clicking `See details`

![Screenshot of Customization Details pane](/devbox-intelligent-apps/media/customization-details-creating.png)

- When your Dev Box is created, it will say `Running` and you can click `Customizations` to see those details

![Screenshot of Dev Box running in Dev Portal](/devbox-intelligent-apps/media/devbox-running.png)


![Screenshot of completed Customization details](/devbox-intelligent-apps/media/customization-details-done.png)

- You can than connect to your Dev Box either via RDP or in the browser

![Screenshot of Connect with the Remote Desktop Client](/devbox-intelligent-apps/media/connect-to-devbox.png)
