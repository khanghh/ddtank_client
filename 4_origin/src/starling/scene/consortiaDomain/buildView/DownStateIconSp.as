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
      
      public function DownStateIconSp(buildId:int)
      {
         super();
         _buildId = buildId;
         ConsortiaDomainManager.instance.addEventListener("event_repair_player_num_change",onRepairPlayerNumChange);
      }
      
      public function set state(value:int) : void
      {
         var repairLabel:* = null;
         var progressBg:* = null;
         var hpLabel:* = null;
         var progressBg2:* = null;
         if(_state != value)
         {
            clear();
            if(value != 1)
            {
               if(value == 2)
               {
                  _downGradeTf = new TextField(200,40,LanguageMgr.GetTranslation("consortiadomain.canGradeUp"),"Arial",24,4278949358,true);
                  _downGradeTf.filter = BlurFilter.createGlow(0,1,2);
                  _downGradeTf.x = 11;
                  addChild(_downGradeTf);
               }
               else if(value == 3 || value == 4)
               {
                  repairLabel = new Image(DDTAssetManager.instance.getTexture("consortiaDomainCompleteDegree"));
                  addChild(repairLabel);
                  progressBg = new Image(DDTAssetManager.instance.getTexture("consortiaDomainProgressBg"));
                  progressBg.x = 46;
                  progressBg.y = 1;
                  addChild(progressBg);
                  _progressImage = new Image(DDTAssetManager.instance.getTexture("consortiaDomainProgressGreen"));
                  _progressImage.x = 48;
                  _progressImage.y = 4;
                  addChild(_progressImage);
                  _progressImageW = _progressImage.width;
               }
               else if(value == 5 || value == 6)
               {
                  hpLabel = new Image(DDTAssetManager.instance.getTexture("consortiaDomainHp"));
                  addChild(hpLabel);
                  progressBg2 = new Image(DDTAssetManager.instance.getTexture("consortiaDomainProgressBg"));
                  progressBg2.x = 46;
                  progressBg2.y = 1;
                  addChild(progressBg2);
                  _progressImage = new Image(DDTAssetManager.instance.getTexture("consortiaDomainProgressRed"));
                  _progressImage.x = 48;
                  _progressImage.y = 4;
                  addChild(_progressImage);
                  _progressImageW = _progressImage.width;
               }
            }
            createTips(value);
            _state = value;
         }
         var eachBuildInfo:EachBuildInfo = ConsortiaDomainManager.instance.model.allBuildInfo[_buildId];
         if(value == 3 || value == 4)
         {
            _progressImage.width = _progressImageW * (ConsortiaDomainManager.instance.consortiaLandRepairBlood - eachBuildInfo.Repair) / ConsortiaDomainManager.instance.consortiaLandRepairBlood;
         }
         else if(value == 6 || value == 5)
         {
            _progressImage.width = _progressImageW * eachBuildInfo.Blood / ConsortiaDomainManager.instance.consortiaLandBuildBlood;
         }
      }
      
      private function createTips(value:int) : void
      {
         var tipsMsg:* = null;
         var tipsTfX:int = 0;
         var tipsColor:* = 0;
         var eachBuildInfo:* = null;
         if(value == 3)
         {
            eachBuildInfo = ConsortiaDomainManager.instance.model.allBuildInfo[_buildId];
            tipsMsg = LanguageMgr.GetTranslation("consortiadomain.buildRepairTip",eachBuildInfo.repairPlayerNum);
            tipsTfX = 0;
            tipsColor = uint(6289152);
         }
         else if(value == 4)
         {
            tipsMsg = LanguageMgr.GetTranslation("consortiadomain.buildWaitRepairTip");
            tipsTfX = 46;
            tipsColor = uint(6289152);
         }
         else if(value == 6)
         {
            tipsMsg = LanguageMgr.GetTranslation("consortiadomain.buildBeBeatTip");
            tipsTfX = 0;
            tipsColor = uint(16711680);
         }
         if(tipsMsg != null)
         {
            _tipsTf = new TextField(320,20,tipsMsg,"Arial",16,tipsColor,true);
            _tipsTf.filter = BlurFilter.createGlow(0,1,2);
            _tipsTf.hAlign = "left";
            _tipsTf.x = tipsTfX;
            _tipsTf.y = 22;
            addChild(_tipsTf);
         }
      }
      
      public function onRepairPlayerNumChange(evt:Event) : void
      {
         var eachBuildInfo:* = null;
         if(_state == 3)
         {
            eachBuildInfo = ConsortiaDomainManager.instance.model.allBuildInfo[_buildId];
            _tipsTf.text = LanguageMgr.GetTranslation("consortiadomain.buildRepairTip",eachBuildInfo.repairPlayerNum);
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
