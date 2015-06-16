package org.uqbar.project.wollok;

import org.eclipse.osgi.util.NLS;

public class Messages extends NLS {
	private static final String BUNDLE_NAME = "org.uqbar.project.wollok.messages"; //$NON-NLS-1$

	public static String WollokDslValidator_CLASS_NAME_MUST_START_UPPERCASE;
	public static String WollokDslValidator_REFERENCIABLE_NAME_MUST_START_LOWERCASE;
	public static String WollokDslValidator_CANNOT_INSTANTIATE_ABSTRACT_CLASS;
	public static String WollokDslValidator_WCONSTRUCTOR_CALL__ARGUMENTS;
	public static String WollokDslValidator_METHOD_NOT_OVERRIDING;
	public static String WollokDslValidator_METHOD_MUST_HAVE_OVERRIDE_KEYWORD;
	public static String WollokDslValidator_CANNOT_MODIFY_VAL;
	public static String WollokDslValidator_DUPLICATED_METHOD;
	public static String WollokDslValidator_DUPLICATED_NAME;
	public static String WollokDslValidator_METHOD_ON_THIS_DOESNT_EXIST;
	public static String WollokDslValidator_WARN_VARIABLE_NEVER_ASSIGNED;
	public static String WollokDslValidator_ERROR_VARIABLE_NEVER_ASSIGNED;
	public static String WollokDslValidator_VARIABLE_NEVER_USED;
	public static String WollokDslValidator_SUPER_ONLY_IN_CLASSES;
	public static String WollokDslValidator_SUPER_ONLY_OVERRIDING_METHOD;
	public static String WollokDslValidator_SUPER_INCORRECT_ARGS;
	public static String WollokDslValidator_ERROR_TRY_WITHOUT_CATCH_OR_ALWAYS;
	public static String WollokDslValidator_CATCH_ONLY_EXCEPTION;
	public static String WollokDslValidator_POSTFIX_ONLY_FOR_VAR;
	public static String WollokDslValidator_DUPLICATED_CLASS_IN_PACKAGE;
	public static String WollokDslValidator_DUPLICATED_PACKAGE;
	public static String WollokDslValidator_PROGRAM_IN_FILE;
	public static String WollokDslValidator_CLASSES_IN_FILE;
	public static String WollokDslValidator_NATIVE_METHOD_NO_BODY;
	public static String WollokDslValidator_NATIVE_METHOD_NO_OVERRIDE;
	public static String WollokDslValidator_NATIVE_METHOD_ONLY_IN_CLASSES;
	public static String WollokDslValidator_NATIVE_IN_NATIVE_SUBCLASS;
	public static String WollokDslValidator_BINARYOP_ONLY_ON_VARS;
	
	static {
		// initialize resource bundle
		NLS.initializeMessages(BUNDLE_NAME, Messages.class);
	}

	private Messages() {
	}

}