LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

ifdef $SSQLCIPHER_CFLAGS
LOCAL_CFLAGS += ${SQLCIPHER_CFLAGS}
else
LOCAL_CFLAGS += -DSQLITE_HAS_CODEC -DSQLCIPHER_CRYPTO_OPENSSL -DSQLITE_TEMP_STORE=2 \
	-DSQLITE_THREADSAFE=1 -DSQLITE_ENABLE_COLUMN_METADATA -DSQLITE_ENABLE_FTS3_PARENTHESIS \
	-DSQLITE_ENABLE_FTS4 -DSQLITE_ENABLE_FTS4_UNICODE61 -DSQLITE_ENABLE_FTS5 \
	-DSQLITE_ENABLE_MEMORY_MANAGEMENT -DSQLITE_ENABLE_UNLOCK_NOTIFY -DSQLITE_ENABLE_RTREE \
	-DSQLITE_SOUNDEX -DHAVE_USLEEP -DSQLITE_ENABLE_LOAD_EXTENSION -DSQLITE_ENABLE_STAT3 \
	-DSQLITE_ENABLE_STAT4 -DSQLITE_ENABLE_JSON1 -DSQLITE_ENABLE_EXPLAIN_COMMENTS \
	-DSQLITE_DEFAULT_WAL_SYNCHRONOUS=1 -DSQLITE_MAX_VARIABLE_NUMBER=99999 \
	-DSQLITE_DEFAULT_JOURNAL_SIZE_LIMIT=1048576 -DSQLITE_ENABLE_SESSION \
	-DSQLITE_ENABLE_PREUPDATE_HOOK -DSQLITE_ENABLE_DBSTAT_VTAB
endif

LOCAL_CPPFLAGS += -Wno-conversion-null

$(info SQLCipher LOCAL_CFLAGS:${LOCAL_CFLAGS})

LOCAL_SRC_FILES:=                             \
	android_database_SQLiteCommon.cpp     \
	android_database_SQLiteConnection.cpp \
	android_database_SQLiteGlobal.cpp     \
	android_database_SQLiteDebug.cpp      \
	JNIHelp.cpp JniConstants.cpp

LOCAL_SRC_FILES += sqlite3.c

LOCAL_C_INCLUDES += $(LOCAL_PATH) $(LOCAL_PATH)/nativehelper/ $(LOCAL_PATH)/android-libs/include/

LOCAL_MODULE:= libsqlcipher
LOCAL_LDLIBS += -ldl -llog
LOCAL_STATIC_LIBRARIES += static-libcrypto

include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := static-libcrypto
LOCAL_SRC_FILES := $(LOCAL_PATH)/android-libs/$(TARGET_ARCH_ABI)/libcrypto.a
include $(PREBUILT_STATIC_LIBRARY)