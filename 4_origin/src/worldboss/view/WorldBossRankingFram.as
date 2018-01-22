package worldboss.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import worldboss.player.RankingPersonInfo;
   
   public class WorldBossRankingFram extends BaseAlerFrame
   {
      
      public static var _rankingPersons:Array = [];
       
      
      private var titleLineBg:MutipleImage;
      
      private var titleBg:MovieImage;
      
      private var numTitle:FilterFrameText;
      
      private var nameTitle:FilterFrameText;
      
      private var souceTitle:FilterFrameText;
      
      private var _sureBtn:TextButton;
      
      public function WorldBossRankingFram()
      {
         super();
         try
         {
            _init();
            return;
         }
         catch(error:Error)
         {
            UIModuleLoader.Instance.addUIModuleImp("ddtcorei");
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__onCoreiLoaded);
            return;
         }
      }
      
      private function __onCoreiLoaded(param1:UIModuleEvent) : void
      {
         if(param1.module == "ddtcorei")
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__onCoreiLoaded);
            _init();
         }
      }
      
      public function _init() : void
      {
         _rankingPersons = [];
         titleText = LanguageMgr.GetTranslation("worldboss.ranking.title");
         titleBg = ComponentFactory.Instance.creatComponentByStylename("worldboss.RankingFrame.RankingTitleBg");
         addToContent(titleBg);
         titleLineBg = ComponentFactory.Instance.creatComponentByStylename("worldboss.RankingItem.bgLine");
         addToContent(titleLineBg);
         numTitle = ComponentFactory.Instance.creatComponentByStylename("worldboss.ranking.numTitle");
         numTitle.text = LanguageMgr.GetTranslation("worldboss.ranking.num");
         addToContent(numTitle);
         nameTitle = ComponentFactory.Instance.creatComponentByStylename("worldboss.ranking.nameTitle");
         nameTitle.text = LanguageMgr.GetTranslation("worldboss.ranking.name");
         addToContent(nameTitle);
         souceTitle = ComponentFactory.Instance.creatComponentByStylename("worldboss.ranking.souceTitle");
         souceTitle.text = LanguageMgr.GetTranslation("worldboss.ranking.socre");
         addToContent(souceTitle);
         _sureBtn = ComponentFactory.Instance.creat("worldboss.ranking.btn");
         _sureBtn.text = LanguageMgr.GetTranslation("shop.PresentFrame.OkBtnText");
         addToContent(_sureBtn);
         _sureBtn.addEventListener("click",__sureBtnClick);
         addEventListener("response",__frameEventHandler);
      }
      
      public function addPersonRanking(param1:RankingPersonInfo) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Boolean = false;
         if(_rankingPersons.length == 0)
         {
            _rankingPersons.push(param1);
         }
         else
         {
            _loc3_ = 0;
            while(_loc3_ < _rankingPersons.length)
            {
               if((_rankingPersons[_loc3_] as RankingPersonInfo).damage < param1.damage)
               {
                  _rankingPersons.splice(_loc3_,0,param1);
                  return;
               }
               _loc3_++;
            }
            _rankingPersons.push(param1);
         }
      }
      
      public function show() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         var _loc3_:Point = ComponentFactory.Instance.creat("worldBoss.ranking.itemPos");
         _loc2_ = 0;
         while(_loc2_ < _rankingPersons.length)
         {
            _loc1_ = new RankingPersonInfoItem(_loc2_ + 1,_rankingPersons[_loc2_] as RankingPersonInfo);
            _loc1_.x = _loc3_.x;
            _loc1_.y = _loc3_.y * (_loc2_ + 1) + 50;
            addChild(_loc1_);
            _loc2_++;
         }
         LayerManager.Instance.addToLayer(this,1,true,1);
      }
      
      private function __frameEventHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               dispose();
         }
      }
      
      private function __sureBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         super.dispose();
         _loc1_ = 0;
         while(_loc1_ < _rankingPersons.length)
         {
            _rankingPersons.shift();
         }
         removeEventListener("response",__frameEventHandler);
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
