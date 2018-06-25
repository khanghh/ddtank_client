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
      
      private function __onCoreiLoaded(pEvent:UIModuleEvent) : void
      {
         if(pEvent.module == "ddtcorei")
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
      
      public function addPersonRanking(personInfo:RankingPersonInfo) : void
      {
         var i:int = 0;
         var temp:Boolean = false;
         if(_rankingPersons.length == 0)
         {
            _rankingPersons.push(personInfo);
         }
         else
         {
            i = 0;
            while(i < _rankingPersons.length)
            {
               if((_rankingPersons[i] as RankingPersonInfo).damage < personInfo.damage)
               {
                  _rankingPersons.splice(i,0,personInfo);
                  return;
               }
               i++;
            }
            _rankingPersons.push(personInfo);
         }
      }
      
      public function show() : void
      {
         var i:int = 0;
         var item:* = null;
         var pos:Point = ComponentFactory.Instance.creat("worldBoss.ranking.itemPos");
         for(i = 0; i < _rankingPersons.length; )
         {
            item = new RankingPersonInfoItem(i + 1,_rankingPersons[i] as RankingPersonInfo);
            item.x = pos.x;
            item.y = pos.y * (i + 1) + 50;
            addChild(item);
            i++;
         }
         LayerManager.Instance.addToLayer(this,1,true,1);
      }
      
      private function __frameEventHandler(event:FrameEvent) : void
      {
         switch(int(event.responseCode))
         {
            case 0:
            case 1:
               SoundManager.instance.play("008");
               dispose();
         }
      }
      
      private function __sureBtnClick(e:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
         super.dispose();
         for(i = 0; i < _rankingPersons.length; )
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
