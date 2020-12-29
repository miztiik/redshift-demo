from aws_cdk import aws_ec2 as _ec2
from aws_cdk import core


class GlobalArgs():
    """
    Helper to define global statics
    """

    OWNER = "MystiqueAutomation"
    ENVIRONMENT = "production"
    REPO_NAME = "redshift-demo"
    SOURCE_INFO = f"https://github.com/miztiik/{REPO_NAME}"
    VERSION = "2020_12_22"
    MIZTIIK_SUPPORT_EMAIL = ["mystique@example.com", ]


class VpcStack(core.Stack):

    def __init__(
        self,
        scope: core.Construct,
        id: str,
        stack_log_level: str,
        from_vpc_name=None,
        ** kwargs
    ) -> None:
        super().__init__(scope, id, **kwargs)

        if from_vpc_name is not None:
            self.vpc = _ec2.Vpc.from_lookup(
                self, "vpc",
                vpc_name=from_vpc_name
            )
        else:
            self.vpc = _ec2.Vpc(
                self,
                "miztiikEbsPerfTestVpc",
                cidr="10.10.0.0/16",
                max_azs=2,
                nat_gateways=0,
                enable_dns_support=True,
                enable_dns_hostnames=True,
                subnet_configuration=[
                    _ec2.SubnetConfiguration(
                        name="public", cidr_mask=24, subnet_type=_ec2.SubnetType.PUBLIC
                    ),
                    # _ec2.SubnetConfiguration(
                    #     name="app", cidr_mask=24, subnet_type=_ec2.SubnetType.PRIVATE
                    # ),
                    _ec2.SubnetConfiguration(
                        name="db", cidr_mask=24, subnet_type=_ec2.SubnetType.ISOLATED
                    )
                ]
            )

        output_0 = core.CfnOutput(
            self,
            "AutomationFrom",
            value=f"{GlobalArgs.SOURCE_INFO}",
            description="To know more about this automation stack, check out our github page."
        )

    # properties to share with other stacks
    @property
    def get_vpc(self):
        return self.vpc

    @property
    def get_vpc_public_subnet_ids(self):
        return self.vpc.select_subnets(
            subnet_type=_ec2.SubnetType.PUBLIC
        ).subnet_ids

    @property
    def get_vpc_private_subnet_ids(self):
        return self.vpc.select_subnets(
            subnet_type=_ec2.SubnetType.PRIVATE
        ).subnet_ids
