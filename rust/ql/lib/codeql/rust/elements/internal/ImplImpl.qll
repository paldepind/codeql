/**
 * This module provides a hand-modifiable wrapper around the generated class `Impl`.
 *
 * INTERNAL: Do not use.
 */

private import codeql.rust.elements.internal.generated.Impl
private import codeql.rust.elements.Function

/**
 * INTERNAL: This module contains the customizable definition of `Impl` and should not
 * be referenced directly.
 */
module Impl {
  // the following QLdoc is generated: if you need to edit it, do it in the schema file
  /**
   * A Impl. For example:
   * ```rust
   * todo!()
   * ```
   */
  class Impl extends Generated::Impl {
    override string toStringImpl() {
      exists(string trait |
        (
          trait = this.getTrait().toAbbreviatedString() + " for "
          or
          not this.hasTrait() and trait = ""
        ) and
        result = "impl " + trait + this.getSelfTy().toAbbreviatedString() + " { ... }"
      )
    }

    /** Gets the method with name `name` in this impl block, if any. */
    Function getMethod(string name) {
      result = this.getAssocItemList().getAnAssocItem() and
      result.getName().getText() = name and
      result.getParamList().hasSelfParam()
    }

    predicate hasMethod(string name) { exists(this.getMethod(name)) }
  }
}
