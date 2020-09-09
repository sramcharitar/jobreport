<g:if test="${report.fieldTeam.size()}">
    <a href="#" id="quickAccess" onclick="teamConfig(${report.id}, event)"><asset:image src="/icons/team.png" width="20px" height="20px"/></a>
</g:if>
<g:else>
    <a href="#" id="quickAccess" onclick="teamConfig(${report.id}, event)"><asset:image src="/icons/no_member.png" width="20px" height="20px"/></a>
</g:else>