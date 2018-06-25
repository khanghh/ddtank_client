package texpSystem.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.ITransformableTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.LanguageMgr;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import texpSystem.controller.TexpManager;
   import texpSystem.data.TexpInfo;
   
   public class TexpInfoTip extends Sprite implements ITransformableTip, Disposeable
   {
       
      
      private const NAME_COLOR:Array = ["#24e198","#f33232","#36baff","#69e000","#ffae00","#fd00e7","#a57bfe"];
      
      private var _bg:ScaleBitmapImage;
      
      private var _line:ScaleBitmapImage;
      
      private var _txtTitle:FilterFrameText;
      
      private var _txtContent:FilterFrameText;
      
      private var _tipWidth:int;
      
      private var _tipHeight:int;
      
      private var _tipData:PlayerInfo;
      
      public function TexpInfoTip()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("texpSystem.texpInfoTip.bg");
         _line = ComponentFactory.Instance.creatComponentByStylename("texpSystem.texpInfoTip.line");
         _txtTitle = ComponentFactory.Instance.creatComponentByStylename("texpSystem.texpInfoTip.title");
         _txtContent = ComponentFactory.Instance.creatComponentByStylename("texpSystem.texpInfoTip.content");
         _txtTitle.text = LanguageMgr.GetTranslation("texpSystem.view.TexpInfoTip.title");
         addChild(_bg);
         addChild(_line);
         addChild(_txtTitle);
         addChild(_txtContent);
      }
      
      public function get tipWidth() : int
      {
         return _tipWidth;
      }
      
      public function set tipWidth(w:int) : void
      {
         _tipWidth = w;
      }
      
      public function get tipHeight() : int
      {
         return _tipHeight;
      }
      
      public function set tipHeight(h:int) : void
      {
         _tipHeight = h;
      }
      
      public function get tipData() : Object
      {
         return _tipData;
      }
      
      public function set tipData(data:Object) : void
      {
         var info:PlayerInfo = data as PlayerInfo;
         if(!info)
         {
            return;
         }
         _tipData = info;
         _txtContent.htmlText = getHtmlText(TexpManager.Instance.getInfo(1,_tipData.attTexpExp)) + "\n" + getHtmlText(TexpManager.Instance.getInfo(2,_tipData.defTexpExp)) + "\n" + getHtmlText(TexpManager.Instance.getInfo(3,_tipData.spdTexpExp)) + "\n" + getHtmlText(TexpManager.Instance.getInfo(4,_tipData.lukTexpExp)) + "\n" + getHtmlText(TexpManager.Instance.getInfo(5,_tipData.magicAtkTexpExp)) + "\n" + getHtmlText(TexpManager.Instance.getInfo(6,_tipData.magicDefTexpExp)) + "\n" + getHtmlText(TexpManager.Instance.getInfo(0,_tipData.hpTexpExp));
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      private function getHtmlText(texp:TexpInfo) : String
      {
         return LanguageMgr.GetTranslation("texpSystem.view.TexpInfoTip.content",NAME_COLOR[texp.type],TexpManager.Instance.getName(texp.type),texp.currEffect,texp.lv);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _line = null;
         _txtTitle = null;
         _txtContent = null;
         _tipData = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
