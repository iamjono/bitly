// THE XML_TREE TRAIT
define xml_tree_trait => trait {
 
    provide attr() => {
        local(out = map)
        with attr in .attributes
        do #out->insert(#attr->name = #attr->value)
 
        return #out
    }
 
    provide attribute(name::string) => .getAttribute(#name) || ''
 
    provide getNode(nodename::string, count::integer = -1) => {
        local(matches = .extract('*[translate(local-name(), \'ABCDEFGHIJKLMNOPQRSTUVWXYZ\', \'abcdefghijklmnopqrstuvwxyz\') = translate(\'' + #nodename + '\', \'ABCDEFGHIJKLMNOPQRSTUVWXYZ\', \'abcdefghijklmnopqrstuvwxyz\')]'))
 
        #matches->size == 0?
            return .attribute(#nodename)
 
        #matches->size == 1?
            return #matches->first
 
        #count != -1?
            protect => {
                return #matches->get(integer(#count))
            }
        return #matches
    }
 
    provide getnodes() => (with node in .childNodes
        where #node->type != ::xml_text || regexp(`\S`) == #node->nodeValue
        select #node)->asStaticArray
 
    provide _unknowntag(...params) => {
        #params && params->size?
            return .getnode(tag_name->asString, #params->first)
        return .getnode(tag_name->asString)
    }
 
}
 
// ADD THE XML_TREE_TRAIT TO XML_ELEMENTS
::xml_element->getType->addTrait(xml_tree_trait)
 
// THE XML_TREE CREATOR FOR COMPATIBILITY
define xml_tree(src::string) => xml(#src)