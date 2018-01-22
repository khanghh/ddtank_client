package ddtmatch.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddtmatch.manager.DDTMatchManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import road7th.comm.PackageIn;
   
   public class DDTMatchFightKingView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _activityTimeTxt:FilterFrameText;
      
      private var _activityInfoTxt:FilterFrameText;
      
      private var _myscoreTxt:FilterFrameText;
      
      private var _vbox:VBox;
      
      private var scrollPanel:ScrollPanel;
      
      public function DDTMatchFightKingView()
      {
         super();
         initView();
         addEvent();
         SocketManager.Instance.out.getRedFightKingScore();
      }
      
      private function initView() : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc1_:* = null;
         _bg = ComponentFactory.Instance.creatBitmap("ddtmatch.fightKingBg");
         addChild(_bg);
         _activityTimeTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.fightKing.activityTimeTxt");
         addChild(_activityTimeTxt);
         _activityTimeTxt.text = ServerConfigManager.instance.getFairBattleScoreBeginTime() + "--" + ServerConfigManager.instance.getFairBattleScoreEndTime();
         _activityInfoTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.fightKing.activityInfoTxt");
         addChild(_activityInfoTxt);
         _activityInfoTxt.text = LanguageMgr.GetTranslation("ddt.DDTMatch.fightKing.activityInfo");
         _myscoreTxt = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.fightKing.myscoreTxt");
         addChild(_myscoreTxt);
         _vbox = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.fightKing.vBox");
         _loc4_ = 0;
         while(_loc4_ < DDTMatchManager.instance.list.length)
         {
            _loc2_ = DDTMatchManager.instance.list[_loc4_].split(":")[0];
            _loc3_ = DDTMatchManager.instance.list[_loc4_].split(":")[1].split("|");
            _loc1_ = new DDTMatchFightKingItem(_loc2_,_loc3_);
            _vbox.addChild(_loc1_);
            _loc4_++;
         }
         scrollPanel = ComponentFactory.Instance.creatComponentByStylename("ddtmatch.fightKing.scrollPanel");
         scrollPanel.setView(_vbox);
         scrollPanel.invalidateViewport();
         addChild(scrollPanel);
      }
      
      private function addEvent() : void
      {
         DDTMatchManager.instance.addEventListener("fightKing",__onFightKingSocreInfo);
      }
      
      private function __onFightKingSocreInfo(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         _myscoreTxt.text = String(_loc2_.readInt());
         _loc2_.readInt();
      }
      
      private function removeEvent() : void
      {
         DDTMatchManager.instance.removeEventListener("fightKing",__onFightKingSocreInfo);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_activityTimeTxt);
         _activityTimeTxt = null;
         ObjectUtils.disposeObject(_activityInfoTxt);
         _activityInfoTxt = null;
         ObjectUtils.disposeObject(_myscoreTxt);
         _myscoreTxt = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(scrollPanel);
         scrollPanel = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
