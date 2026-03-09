config.load_autoconfig(True)
# c.qt.args = [
#     'enable-features="dns-over-https<DoHTrial"',
#     'force-fieldtrials="DohTrial/Group1"',
#     'force-fieldtrial-params="DoHTrial.Group1:server/https://extended.dns.mullvad.net/dns-query/method/POST"',
#     # 'force-fieldtrial-params="DohProviderEnabled/true"',
#     # 'doh-url="https://extended.dns.mullvad.net/dns-query"'
# ]
c.auto_save.session = False
c.tabs.position = "bottom"
c.statusbar.position = "bottom"
# c.content.headers.user_custom = "Dns-Over-Https: https://extended.dns.mullvad.net/dns-query"

# c.dns.doh_providers = {
#     'quad9': {
#         'url': 'https://dns.quad9.net/dns-query',
#         'tls_trusted_certificate': None,
#     }
# }
# c.dns.over_https = True
# c.dns.doh_provider = 'quad9'
