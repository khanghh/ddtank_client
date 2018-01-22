package gemstone.views
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import gemstone.GemstoneManager;
   import gemstone.info.GemstoneInfo;
   import gemstone.info.GemstoneStaticInfo;
   import gemstone.items.FigSoulItem;
   import gemstone.items.Item;
   
   public class GemstoneInfoView extends Frame
   {
       
      
      private var _stoneItemList:Vector.<Item>;
      
      private var _kind:FilterFrameText;
      
      private var _effect:FilterFrameText;
      
      private var _titleBg1:Bitmap;
      
      private var _titleBg2:Bitmap;
      
      private var _effDesc:FilterFrameText;
      
      private var _zhanhunList:VBox;
      
      private var _loader:BaseLoader;
      
      private var _gInfoList:Vector.<GemstoneStaticInfo>;
      
      private var _item1:FigSoulItem;
      
      private var _item2:FigSoulItem;
      
      private var _item3:FigSoulItem;
      
      private var _item4:FigSoulItem;
      
      private var _item5:FigSoulItem;
      
      private var _redUrl:String;
      
      private var _bulUrl:String;
      
      private var _greUrl:String;
      
      private var _yelUrl:String;
      
      private var _bg:Bitmap;
      
      private var _othersTxt:FilterFrameText;
      
      private var _road:FilterFrameText;
      
      private var _line:Bitmap;
      
      public function GemstoneInfoView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("gemstone.rigth.view");
         addChild(_bg);
         _kind = ComponentFactory.Instance.creatComponentByStylename("zhanhunKind");
         _kind.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.gemstoneKind");
         addChild(_kind);
         _effect = ComponentFactory.Instance.creatComponentByStylename("zhanhunUseded");
         _effect.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.gemstoneEffect");
         addChild(_effect);
         _othersTxt = ComponentFactory.Instance.creatComponentByStylename("othersTxt");
         _othersTxt.text = LanguageMgr.GetTranslation("ddt.gemstone.curInfo.othersTxt");
         addChild(_othersTxt);
         _road = ComponentFactory.Instance.creatComponentByStylename("zhanhunshuoming");
         _road.x = 9;
         _road.y = 390;
         _road.text = LanguageMgr.GetTranslation("ddt.gemstone.obtain.road");
         addChild(_road);
         _zhanhunList = new VBox();
         _zhanhunList.spacing = 5;
         _zhanhunList.x = -5;
         _zhanhunList.y = 46;
         addChild(_zhanhunList);
         _item1 = new FigSoulItem("gemstone.attck",LanguageMgr.GetTranslation("ddt.gemstone.curInfo.redGemstone"));
         _item1.x = 25;
         _item1.y = 40;
         _item1.tipData = GemstoneManager.Instance.redInfoList;
         _item1.height = 40;
         _zhanhunList.addChild(_item1);
         _item2 = new FigSoulItem("gemstone.defense",LanguageMgr.GetTranslation("ddt.gemstone.curInfo.bluGemstone"));
         _item2.x = 25;
         _item2.y = 90;
         _item2.tipData = GemstoneManager.Instance.bluInfoList;
         _item2.height = 40;
         _zhanhunList.addChild(_item2);
         _item3 = new FigSoulItem("gemstone.agile",LanguageMgr.GetTranslation("ddt.gemstone.curInfo.gesGemstone"));
         _item3.x = 25;
         _item3.y = 140;
         _item3.tipData = GemstoneManager.Instance.greInfoList;
         _item3.height = 40;
         _zhanhunList.addChild(_item3);
         _item4 = new FigSoulItem("gemstone.lucky",LanguageMgr.GetTranslation("ddt.gemstone.curInfo.yelGemstone"));
         _item4.x = 25;
         _item4.y = 190;
         _item4.tipData = GemstoneManager.Instance.yelInfoList;
         _item4.height = 40;
         _zhanhunList.addChild(_item4);
         _item5 = new FigSoulItem("gemstone.hp",LanguageMgr.GetTranslation("ddt.gemstone.curInfo.purpleGemstone"));
         _item5.x = 25;
         _item5.y = 190;
         _item5.tipData = GemstoneManager.Instance.purpleInfoList;
         _item5.height = 40;
         _zhanhunList.addChild(_item5);
         _zhanhunList.arrange();
         _line = ComponentFactory.Instance.creatBitmap("gemstone.line");
         addChild(_line);
         _effDesc = ComponentFactory.Instance.creatComponentByStylename("zhanhunshuoming");
         _effDesc.text = LanguageMgr.GetTranslation("ddt.gemstone.obtain.effDescri");
         addChild(_effDesc);
      }
      
      public function initGemstone(param1:Vector.<GemstoneInfo>) : void
      {
      }
      
      override public function dispose() : void
      {
         if(_titleBg1)
         {
            ObjectUtils.disposeObject(_titleBg1);
         }
         _titleBg1 = null;
         if(_titleBg2)
         {
            ObjectUtils.disposeObject(_titleBg2);
         }
         _titleBg2 = null;
         if(_kind)
         {
            ObjectUtils.disposeObject(_kind);
         }
         _kind = null;
         if(_effect)
         {
            ObjectUtils.disposeObject(_effect);
         }
         _effect = null;
         if(_item1)
         {
            ObjectUtils.disposeObject(_item1);
         }
         _item1 = null;
         if(_item2)
         {
            ObjectUtils.disposeObject(_item2);
         }
         _item2 = null;
         if(_item3)
         {
            ObjectUtils.disposeObject(_item3);
         }
         _item3 = null;
         if(_item4)
         {
            ObjectUtils.disposeObject(_item4);
         }
         _item4 = null;
         if(_item5)
         {
            ObjectUtils.disposeObject(_item5);
         }
         _item5 = null;
         if(_zhanhunList)
         {
            ObjectUtils.disposeObject(_zhanhunList);
         }
         _zhanhunList = null;
      }
   }
}
