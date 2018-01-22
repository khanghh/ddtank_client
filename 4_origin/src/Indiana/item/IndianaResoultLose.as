package Indiana.item
{
   import Indiana.IndianaDataManager;
   import Indiana.analyzer.IndianaShopItemInfo;
   import Indiana.model.IndianaShowData;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.TextEvent;
   import road7th.utils.DateUtils;
   
   public class IndianaResoultLose extends Sprite implements Disposeable
   {
       
      
      private var _prompte:Bitmap;
      
      private var _txt:GradientBitmapText;
      
      private var _dis:FilterFrameText;
      
      private var _disII:FilterFrameText;
      
      private var _lookNum:FilterFrameText;
      
      private var _line:MutipleImage;
      
      private var _info:IndianaShopItemInfo;
      
      private var _endDate:Date;
      
      private var _data:IndianaShowData;
      
      public function IndianaResoultLose()
      {
         super();
         initView();
         initEvent();
      }
      
      public function setInfo(param1:IndianaShopItemInfo) : void
      {
         _info = param1;
         if(_info)
         {
            _endDate = DateUtils.decodeDated(_info.EndShowTime);
            _data = IndianaDataManager.instance.currentShowData;
            if(_data.joinCount > 0)
            {
               _lookNum.htmlText = LanguageMgr.GetTranslation("Indiana.resoult.checkSelfCode");
               _disII.text = LanguageMgr.GetTranslation("Indiana.resoult.checkSelfCodeII",_data.joinCount);
            }
            else
            {
               _disII.text = LanguageMgr.GetTranslation("Indiana.infopanel.disIIII");
            }
         }
      }
      
      private function initView() : void
      {
         _prompte = ComponentFactory.Instance.creatBitmap("asset.indiana.promp.lose");
         _txt = new GradientBitmapText();
         _txt.FilterTxtStyle = "indiana.gradient.Txt";
         _txt.BitMapStyle = "asset.gradient.bg";
         _txt.setText(LanguageMgr.GetTranslation("Indiana.resoultLost.dis"));
         PositionUtils.setPos(_txt,"indiana.resoultloseNum.pos");
         _dis = ComponentFactory.Instance.creatComponentByStylename("indiana.itemDis.Txt");
         _dis.text = LanguageMgr.GetTranslation("Indiana.resoultLost.disII");
         PositionUtils.setPos(_dis,"indiana.resoultloseDis.pos");
         _disII = ComponentFactory.Instance.creatComponentByStylename("indiana.itemDis.Txt");
         PositionUtils.setPos(_disII,"indiana.resoultlookself.pos");
         _lookNum = ComponentFactory.Instance.creatComponentByStylename("indiana.itemDis.Txt");
         _lookNum.mouseEnabled = true;
         PositionUtils.setPos(_lookNum,"indiana.resoultlose.lookself.pos");
         _line = ComponentFactory.Instance.creatComponentByStylename("indiana.line_3");
         addChild(_prompte);
         addChild(_txt);
         addChild(_dis);
         addChild(_disII);
         addChild(_line);
      }
      
      private function initEvent() : void
      {
         _lookNum.addEventListener("link",__linkHandler);
      }
      
      private function __linkHandler(param1:TextEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Array = param1.text.split("|");
         var _loc4_:String = _loc3_[0];
         if(_loc4_ == "clickother")
         {
            _loc2_ = _loc3_[1];
         }
         if(_loc4_ == "clickself")
         {
            _loc2_ = PlayerManager.Instance.Self.ID;
         }
         SocketManager.Instance.out.sendIndianaCode(_data.per_id,_loc2_);
      }
      
      public function dispose() : void
      {
         _lookNum.removeEventListener("link",__linkHandler);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         ObjectUtils.disposeAllChildren(this);
         _txt = null;
         _prompte = null;
         _dis = null;
         _disII = null;
         _line = null;
         _lookNum = null;
      }
   }
}
