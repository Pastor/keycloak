<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=true; section>
    <#if section = "header">
        ${kcSanitize(msg("webauthn-error-title"))?no_esc}
    <#elseif section = "form">

        <script type="text/javascript">
            refreshPage = () => {
                if ('${execution}' === "webauthn-register") {
                    location.reload();
                    return false;
                }
                document.getElementById('executionValue').value = '${execution}';
                document.getElementById('kc-error-credential-form').submit();
            }
        </script>

        <form id="kc-error-credential-form" class="${properties.kcFormClass!}" action="${url.loginAction}"
              method="post">
            <input type="hidden" id="executionValue" name="authenticationExecution"/>
        </form>

        <#if authenticators??>
            <table class="table">
                <thead>
                <tr>
                    <th>${kcSanitize(msg("webauthn-available-authenticators")?no_esc)}</th>
                </tr>
                </thead>
                <tbody>
                <#list authenticators.authenticators as authenticator>
                    <tr>
                        <th>
                            <span id="kc-webauthn-authenticator">${kcSanitize(authenticator.label)?no_esc}</span>
                        </th>
                    </tr>
                </#list>
                </tbody>
            </table>
        </#if>

        <div id="kc-error-message">
            <input tabindex="4" onclick="refreshPage()" type="button"
                   class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}"
                   name="try-again" id="kc-try-again" value="${kcSanitize(msg("doTryAgain"))?no_esc}"/>
        </div>
    </#if>
</@layout.registrationLayout>