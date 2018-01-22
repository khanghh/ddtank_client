package starling.scene.consortiaDomain.buildView
{
   import consortiaDomain.ConsortiaDomainManager;
   import consortiaDomain.EachBuildInfo;
   import ddt.manager.LanguageMgr;
   import flash.events.Event;
   import road7th.DDTAssetManager;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.filters.BlurFilter;
   import starling.text.TextField;
   
   public class DownStateIconSp extends Sprite
   {
       
      
      private var _buildId:int;
      
      private var _state:int = -1;
      
      private var _downGradeTf:TextField;
      
      private var _progressImage:Image;
      
      private var _tipsTf:TextField;
      
      private var _progressImageW:int = 137;
      
      public function DownStateIconSp(param1:int)
      {
         super();
         _buildId = param1;
         ConsortiaDomainManager.instance.addEventListener("event_repair_player_num_change",onRepairPlayerNumChange);
      }
      
      public function set state(param1:int) : void
      {
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc5_:* = null;
         if(_state != param1)
         {
            clear();
            if(param1 != 1)
            {
               if(param1 == 2)
               {
                  _downGradeTf = new TextField(200,40,LanguageMgr.GetTranslation("consortiadomain.canGradeUp"),"Arial",24,4278949358,true);
                  _downGradeTf.filter = BlurFilter.createGlow(0,1,2);
                  _downGradeTf.x = 11;
                  addChild(_downGradeTf);
               }
               else if(param1 == 3 || param1 == 4)
               {
                  _loc6_ = new Image(DDTAssetManager.instance.getTexture("consortiaDomainCompleteDegree"));
                  addChild(_loc6_);
                  _loc4_ = new Image(DDTAssetManager.instance.getTexture("consortiaDomainProgressBg"));
                  _loc4_.x = 46;
                  _loc4_.y = 1;
                  addChild(_loc4_);
                  _progressImage = new Image(DDTAssetManager.instance.getTexture("consortiaDomainProgressGreen"));
                  _progressImage.x = 48;
                  _progressImage.y = 4;
                  addChild(_progressImage);
                  _progressImageW = _progressImage.width;
               }
               else if(param1 == 5 || param1 == 6)
               {
                  _loc3_ = new Image(DDTAssetManager.instance.getTexture("consortiaDomainHp"));
                  addChild(_loc3_);
                  _loc5_ = new Image(DDTAssetManager.instance.getTexture("consortiaDomainProgressBg"));
                  _loc5_.x = 46;
                  _loc5_.y = 1;
                  addChild(_loc5_);
                  _progressImage = new Image(DDTAssetManager.instance.getTexture("consortiaDomainProgressRed"));
                  _progressImage.x = 48;
                  _progressImage.y = 4;
                  addChild(_progressImage);
                  _progressImageW = _progressImage.width;
               }
            }
            createTips(param1);
            _state = param1;
         }
         var _loc2_:EachBuildInfo = ConsortiaDomainManager.instance.model.allBuildInfo[_buildId];
         if(param1 == 3 || param1 == 4)
         {
            _progressImage.width = _progressImageW * (ConsortiaDomainManager.instance.consortiaLandRepairBlood - _loc2_.Repair) / ConsortiaDomainManager.instance.consortiaLandRepairBlood;
         }
         else if(param1 == 6 || param1 == 5)
         {
            _progressImage.width = _progressImageW * _loc2_.Blood / ConsortiaDomainManager.instance.consortiaLandBuildBlood;
         }
      }
      
      private function createTips(param1:int) : void
      {
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc5_:* = 0;
         var _loc2_:* = null;
         if(param1 == 3)
         {
            _loc2_ = ConsortiaDomainManager.instance.model.allBuildInfo[_buildId];
            _loc3_ = LanguageMgr.GetTranslation("consortiadomain.buildRepairTip",_loc2_.repairPlayerNum);
            _loc4_ = 0;
            _loc5_ = uint(6289152);
         }
         else if(param1 == 4)
         {
            _loc3_ = LanguageMgr.GetTranslation("consortiadomain.buildWaitRepairTip");
            _loc4_ = 46;
            _loc5_ = uint(6289152);
         }
         else if(param1 == 6)
         {
            _loc3_ = LanguageMgr.GetTranslation("consortiadomain.buildBeBeatTip");
            _loc4_ = 0;
            _loc5_ = uint(16711680);
         }
         if(_loc3_ != null)
         {
            _tipsTf = new TextField(320,20,_loc3_,"Arial",16,_loc5_,true);
            _tipsTf.filter = BlurFilter.createGlow(0,1,2);
            _tipsTf.hAlign = "left";
            _tipsTf.x = _loc4_;
            _tipsTf.y = 22;
            addChild(_tipsTf);
         }
      }
      
      public function onRepairPlayerNumChange(param1:Event) : void
      {
         var _loc2_:* = null;
         if(_state == 3)
         {
            _loc2_ = ConsortiaDomainManager.instance.model.allBuildInfo[_buildId];
            _tipsTf.text = LanguageMgr.GetTranslation("consortiadomain.buildRepairTip",_loc2_.repairPlayerNum);
         }
      }
      
      private function clear() : void
      {
         removeChildren(0,-1,true);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ConsortiaDomainManager.instance.removeEventListener("event_repair_player_num_change",onRepairPlayerNumChange);
         _downGradeTf = null;
         _progressImage = null;
         _tipsTf = null;
      }
   }
}
