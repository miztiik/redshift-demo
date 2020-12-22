#!/usr/bin/env python3

from aws_cdk import core

from redshift_demo.redshift_demo_stack import RedshiftDemoStack


app = core.App()
RedshiftDemoStack(app, "redshift-demo")

app.synth()
