package com.primeton.dgs.kernel.core.web.ontolog;
 import com.primeton.dgs.kernel.core.cache.ICache;
 import com.primeton.dgs.kernel.core.common.SpringContextHelper;
 import com.primeton.dgs.workspace.system.common.UserProfile;
 import javax.servlet.http.HttpSession;
public class AppDispatchCommand    extends AppBaseDispatchCommand
 {
   private ICache cache;
  
   protected UserProfile getCurrentUser()
   {
    return (UserProfile)session.getAttribute(UserProfile.KEY);
   }
   

 
  protected ICache getCache()
   {
     if (cache == null) {
       cache = ((ICache)SpringContextHelper.getBean("cache"));
     }
     return cache;
   }
 }

