/************** 
 
 build by Eric
 
 **************/
///MQTT chat protocol
///0为取之后消息,1为取之前的消息
#define HP_CHAT_AFTER           @"0"
#define HP_CHAT_BEFORE          @"1"

#define HP_CHAT_SYNC            @"/message/sync"
#define HP_CHAT_HISTORY         @"/message/history"

///end MQTT


///需要sig   1需要 0不需要
///用户重置密码设置 0
//#define HP_USER_PWDSET                  @"api/client/login"

///上传图片
#define HP_IMAGE_UPLOAD                 @"api/chat/photoupload"

/**
 *  重置密码 0
 */
#define HP_RESET_PWD                    @"api/user/resetPassword"
/**
 *  手机验证 0
 */
#define HP_PHONE_VERIFY                 @"api/phone/verifycode"
/**
 *  用户注册 0
 */
#define HP_RERDISTER_USER               @"api/user/register"
/**
 *  登录 0
 */
#define HP_USER_LOGIN                   @"api/user/login"

/**
 *  获取聊天好友
 */
#define HP_FRIENDRELATION_GET           @"api/friendrelation/get"
/**
 *  添加聊天好友
 */
#define HP_FRIENDRELATION_ADD           @"api/friendrelation/add"
/**
 *  删除聊天好友
 */
#define HP_FRIENDRELATION_DELETE           @"api/friendrelation/delete"
/**
 *  用户退出
 */
#define HP_USER_LOGOUT                  @"api/user/logout"
/**
 *  用户切换身份
 *  identityType   身份类型，0:牛人 1:boss 以后可能还要加2猎头
 */
#define HP_USER_SWITCH                  @"api/switch/identity"


/**
 *  编辑用户信息
 */
#define HP_USER_INFOEDIT                @"api/user/infoedit"
/**
 *  修改图片
 */
#define HP_USER_EDITIMG                 @"api/user/editimg"
/**
 *  添加诱惑内容
 */
#define HP_ADD_CONTENT                  @"api/lure/updateContent"
/**
 *  添加诱惑关键字
 */
#define HP_ADD_KEYWORD                  @"api/lure/addkeyword"
/**
 *  查看诱惑
 */
#define HP_GET_CONTENT                  @"api/lure/get"
/**
 *  获取工作分类基础数据 0
 */
#define HP_KINDOFJOB                    @"api/config/get"
/**
 *  添加职位
 */
#define HP_ADD_POSITION                 @"api/job/update"
/**
 *  获取简单职位列表
 */
#define HP_GET_SIMJOBLIST               @"api/job/getSimpleList"
/**
 *  获取逛boss列表 0
 */
#define HP_USER_STROLLBOSS              @"api/user/strollBoss"
/**
 *  获取逛牛人列表 0
 */
#define HP_USER_STROLLNIUREN            @"api/user/strollNiuren"
/**
 *  排序工作
 */
#define HP_JOB_SORT                     @"api/job/updateSort"
/**
 *  工作详情 0
 */
#define HP_JOB_DETAIL                   @"api/job/getDetail"
/**
 *  删除职位
 */
#define HP_DEL_JOB                      @"api/job/delete"
/**
 * 添加更新快捷回复
 */
#define HP_FASTREPLY_UPDATE             @"api/fastreply/update"
/**
 * 获取快捷回复
 */
#define HP_FASTREPLY_GET                @"api/fastreply/get"
/**
 * 更新用户关系备忘
 */
#define HP_RELATION_UPDATE              @"api/friendrelation/updateremind"
/**
 *  添加经历
 */
#define HP_ADD_EXP                      @"api/experience/update"
/**
 * 更新添加问候语
 */
#define HP_GREET_UPDATE                 @"api/greeting/update"
/**
 * 获取问候语
 */
#define HP_GREET_GET                    @"api/greeting/get"


/**
 *  删除经历
 */
#define HP_DEL_EXP                      @"api/experience/delete"
/**
 *  获取经历列表
 */
#define HP_EDULIST                      @"api/experience/getExpList"
/**
 *  经历排序
 */
#define HP_EDU_SORT                     @"api/experience/updateSort"
/**
 * 获取牛人或boss详情 0 
 */
#define HP_USER_SEARCHDETAIL             @"api/user/searchUserDetail"
/**
 *  经历
 */
#define HP_EDU_DETAIL                    @"api/experience/getDetail"
/**
 *  添加站台
 */
#define HP_ADD_INVITE                    @"api/recommendInvite/update"
/**
 *  获取站台信息 0
 */
#define HP_GET_INVITE                    @"api/recommendInvite/get"

/**
 *  删除快捷回复
 */
#define HP_FASTREPLY_DELETE              @"api/fastreply/delete"

/**
 *  上传通讯录 0
 */
#define HP_CONTACT_UPLOAD                @"api/contact/upload"
/**
 * 绑定账号和使用微博的账号和密码
 */
#define HP_BIND_THIRDPART                @"api/bind/thirdpart"
/**
 *  更改密码
 */
#define HP_CHANGE_PWD                    @"api/user/modifyPassword"
/**
 *  二维码扫面进入web编辑
 */
#define HP_EDIT_WEB                      @"api/web/edit"
/**
 *  更新apns token
 */
#define HP_APNS_UPDATE                   @"api/apnstoken/update"
/**
 *  更新站台
 */
#define HP_SORT_RECOM                    @"api/recommendInvite/updatesort"
/**
 *  删除站台人
 */
#define HP_DELT_STATION                  @"api/recommendInvite/delete"

/**
 *  升级接口 0
 */
#define HP_UPGRADE_CHECK                 @"api/upgrade/check"
/**
 *  注销 0
 */
#define HP_DELE                          @"api/test/cmd"
/**
 *  重新邀请
 */
#define HP_REINVITE                      @"api/recommendInvite/reInvite"

/**
 *  删除当前的背景图
 */
#define HP_DELE_BG                       @"api/user/restoreCoverimg"
/**
 *  extra数据get 0
 */
#define HP_GET_EXTRA                     @"api/data/get"

/**
 *  用户认证
 */
#define HP_CERTIFICATE                   @"api/user/certificate"
/**
 *  验证邀请码 0
 */
#define HP_CHECKCODE                     @"api/userInvitation/checkcode"
/**
 *  奖金统计
 */
#define HP_STAT                          @"api/userInvitation/getStat"
/**
 *  检查是否注册 0
 */
#define HP_CHECKLOGIN                    @"api/user/checkAccount"
/**
 *  获取Boss详情 0 
 */
#define HP_BOSS_DETAIl                    @"api/user/bossDetail"
/**
 *  获取牛人详情 0 
 */
#define HP_SEEKER_DETAIl                    @"api/user/niurenDetail"
/**
 *  用户地点
 */
#define HP_LOCATION                         @"api/user/location"
/**
 *  推荐boss
 */
#define HP_Recommend_BOSS                  @"api/recommendedBoss/get"
/**
 *  推荐牛人
 */
#define HP_Recommend_GEEK                  @"api/recommendedNiuren/get"
/**
 *  组合接口
 */
#define HP_BATCH                          @"api/batch/batchRun"
/**
 *  广告接口
 */
#define HP_AD_GET                          @"api/adActivity/get"
/**
 *  添加黑名单
 */
#define HP_ADD_BLACK                       @"api/userBlack/add"
/**
 *  移除黑名单
 */
#define HP_DEL_BLACK                       @"api/userBlack/delete"
/**
 *  3.0
 */
/**
 *  更新个人资料
 */
#define HP_PROFILE_UP                         @"api/userProfile/update"

/**
 *  获取牛人信息   自己什么都不传
 */
#define HP_GET_RESUME                       @"api/userResume/get"
/**
 *  添加作品
 */
#define HP_ADD_PRODUCTION                   @"api/userProfile/updateProduction"
/**
 *  删除作品
 */
#define HP_DELE_PRODUTION                   @"api/userProfile/deleteProduction"
/**
 *  回答问题
 */
#define HP_ANSWER                           @"api/answers/add"
///获取问题
#define HP_GET_QUWSTION                     @"api/questions/get"
///邀请答题
#define HP_INVITE                           @"api/answerQuestion/invite"
///删除信息
#define HP_DELE_MES                         @"api/message/delete"

/**
 *  请求拒接
 */
#define HP_REJECT_CONTENT                   @"api/answerRequest/reject"

/**
 *  获取问答
 */
#define HP_GET_RQUESTION                    @"api/answerRequest/getById"


/**
 * 批量点击
 */
#define HP_ALL_REQUEST                      @"api/answerRequest/batchclick"

