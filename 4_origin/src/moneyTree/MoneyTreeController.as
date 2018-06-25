package moneyTree
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.CoreController;
   import ddt.ICoreCtrller;
   import ddt.events.CEvent;
   import ddt.utils.HelperUIModuleLoad;
   import moneyTree.view.MoneyTreeMainFrame;
   
   public class MoneyTreeController extends CoreController implements ICoreCtrller
   {
      
      private static var instance:MoneyTreeController;
       
      
      private var _manager:MoneyTreeManager;
      
      private var _frame:MoneyTreeMainFrame;
      
      public function MoneyTreeController()
      {
         super();
      }
      
      public static function getInstance() : MoneyTreeController
      {
         if(!instance)
         {
            instance = new MoneyTreeController();
         }
         return instance;
      }
      
      public function setup() : void
      {
         _manager = MoneyTreeManager.getInstance();
         var list:Array = ["mt_show_main_frame","mt_hide_main_frame","mt_update_info","mt_update_remain","mt_reset_friends_list","mt_pick_movie","mt_speedup_suc","mt_set_focus"];
         addEvents(list,_manager);
      }
      
      override protected function eventsHandler(e:CEvent) : void
      {
         var _loc2_:* = e.type;
         if("mt_show_main_frame" !== _loc2_)
         {
            if("mt_hide_main_frame" !== _loc2_)
            {
               if("mt_update_info" !== _loc2_)
               {
                  if("mt_update_remain" !== _loc2_)
                  {
                     if("mt_reset_friends_list" !== _loc2_)
                     {
                        if("mt_pick_movie" !== _loc2_)
                        {
                           if("mt_speedup_suc" !== _loc2_)
                           {
                              if("mt_set_focus" === _loc2_)
                              {
                                 setFocus();
                              }
                           }
                           else
                           {
                              onSpeedUpSuc();
                           }
                        }
                        else
                        {
                           onPick(int(e.data));
                        }
                     }
                     else
                     {
                        resetFriendList();
                     }
                  }
                  else
                  {
                     updateRemainNum();
                  }
               }
               else
               {
                  updateViewByInfo();
               }
            }
            else
            {
               hideMainFrame();
            }
         }
         else
         {
            showMainFrame();
         }
      }
      
      private function onSpeedUpSuc() : void
      {
         _frame.playFly();
      }
      
      private function onPick(index:int) : void
      {
         _frame.pick(index);
      }
      
      private function resetFriendList() : void
      {
         if(!_frame || !_frame.parent)
         {
            return;
         }
         _frame.resetFriendList();
      }
      
      private function updateRemainNum() : void
      {
         _frame.updateRemainNum();
      }
      
      private function updateViewByInfo() : void
      {
         if(!_frame || !_frame.parent)
         {
            return;
         }
         _frame.updateRemainNum();
         _frame.updateFruits();
      }
      
      private function hideMainFrame() : void
      {
         if(_frame != null)
         {
            ObjectUtils.disposeObject(_frame);
            _frame = null;
         }
      }
      
      private function showMainFrame() : void
      {
         new HelperUIModuleLoad().loadUIModule(["moneyTree","ddtinvite"],onLoaded);
      }
      
      private function onLoaded() : void
      {
         _frame = ComponentFactory.Instance.creatComponentByStylename("moneyTree.mainframe");
         LayerManager.Instance.addToLayer(_frame,3,true,1);
         _manager.requireUpdateInfo();
      }
      
      private function setFocus() : void
      {
         if(_frame && _frame.parent)
         {
            StageReferance.stage.focus = _frame;
         }
      }
      
      public function BecomeMature() : void
      {
         _frame.updateFruits();
      }
   }
}
