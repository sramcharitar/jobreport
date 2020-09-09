package jobreport

import org.springframework.context.MessageSource
import org.springframework.context.i18n.LocaleContextHolder

enum InventoryStatusEnum {
    EMPTY("Empty"),
    RETURNING_TO_WAREHOUSE("Returning to Warehouse"),
    RETURNED_TO_WAREHOUSE("Returned to Warehouse"),
    LEFT_WITH_CLIENT("Left with Client"),
    OTHER("Other")

    final String value

    InventoryStatusEnum(String value) { this.value = value }

    @Override
    String toString(){
        MessageSource messageSource = MessageSourceHolder.getMessageSource()
        return messageSource.getMessage('inventoryStatusEnum.' + name(), null, value, LocaleContextHolder.getLocale())
    }

    String getKey(){ name() }
}