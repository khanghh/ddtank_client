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
   
   public class IndianaResoultSuccess extends Sprite implements Disposeable
   {
       
      
      private var _luckBg:Bitmap;
      
      private var _luckNum:GradientBitmapText;
      
      private var _nameitem:AttributeItem;
      
      private var _severitem:AttributeItem;
      
      private var _timesnumitem:AttributeItem;
      
      private var _timeitem:AttributeItem;
      
      private var _resoultitem:AttributeItem;
      
      private var _lookNum:FilterFrameText;
      
      private var _lookNumself:FilterFrameText;
      
      private var _lookNumselfII:FilterFrameText;
      
      private var _line:MutipleImage;
      
      private var _data:IndianaShowData;
      
      private var _info:IndianaShopItemInfo;
      
      public function IndianaResoultSuccess()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _luckBg = ComponentFactory.Instance.creatBitmap("asset.LuckNum.bg");
         _luckNum = new GradientBitmapText();
         _luckNum.FilterTxtStyle = "indiana.gradient.Txt";
         _luckNum.BitMapStyle = "asset.gradient.bg";
         PositionUtils.setPos(_luckNum,"indiana.resoultluckNum.pos");
         _nameitem = new AttributeItem("indiana.itemDis.Txt");
         _nameitem.setWidth(160);
         PositionUtils.setPos(_nameitem,"indiana.resoultname.pos");
         _severitem = new AttributeItem("indiana.itemDis.Txt");
         _severitem.setWidth(160);
         PositionUtils.setPos(_severitem,"indiana.resoultsever.pos");
         _timesnumitem = new AttributeItem("indiana.itemDis.Txt");
         _timesnumitem.setWidth(160);
         PositionUtils.setPos(_timesnumitem,"indiana.resoultjoin.pos");
         _timeitem = new AttributeItem("indiana.itemDis.Txt");
         _timeitem.setWidth(200);
         PositionUtils.setPos(_timeitem,"indiana.resoulttime.pos");
         _resoultitem = new AttributeItem("indiana.itemDis.Txt");
         _resoultitem.setWidth(200);
         PositionUtils.setPos(_resoultitem,"indiana.resoultvalue.pos");
         _lookNum = ComponentFactory.Instance.creatComponentByStylename("indiana.itemDis.Txt");
         _lookNum.mouseEnabled = true;
         PositionUtils.setPos(_lookNum,"indiana.resoultlookplayer.pos");
         _lookNumself = ComponentFactory.Instance.creatComponentByStylename("indiana.itemDis.Txt");
         _lookNumselfII = ComponentFactory.Instance.creatComponentByStylename("indiana.itemDis.Txt");
         _lookNumselfII.mouseEnabled = true;
         PositionUtils.setPos(_lookNumselfII,"indiana.resoultsuccess.lookself.pos");
         PositionUtils.setPos(_lookNumself,"indiana.resoultlookself.pos");
         _line = ComponentFactory.Instance.creatComponentByStylename("indiana.line_2");
         addChild(_luckBg);
         addChild(_luckNum);
         addChild(_nameitem);
         addChild(_severitem);
         addChild(_timeitem);
         addChild(_timesnumitem);
         addChild(_resoultitem);
         addChild(_lookNum);
         addChild(_lookNumself);
         addChild(_lookNumselfII);
         addChild(_line);
      }
      
      private function initEvent() : void
      {
         _lookNumselfII.addEventListener("link",__linkHandler);
         _lookNum.addEventListener("link",__linkHandler);
      }
      
      private function removeEvent() : void
      {
         _lookNumselfII.removeEventListener("link",__linkHandler);
         _lookNum.removeEventListener("link",__linkHandler);
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
      
      private function setShowData() : void
      {
         _data = IndianaDataManager.instance.currentShowData;
         if(_data)
         {
            _luckNum.setText(LanguageMgr.GetTranslation("Indiana.resoult.code",_info.PeriodName,_data.luckCode));
            _nameitem.setDis(LanguageMgr.GetTranslation("Indiana.resoult.nickName",_data.nickName));
            _severitem.setDis(LanguageMgr.GetTranslation("Indiana.resoult.severName",_data.areaName));
            _timeitem.setDis(LanguageMgr.GetTranslation("Indiana.resoult.joinTime",DateUtils.dateFormat(_data.joinTime)));
            _resoultitem.setDis(LanguageMgr.GetTranslation("Indiana.resoult.annTime",DateUtils.dateFormat(_data.annTime)));
            _timesnumitem.setDis(LanguageMgr.GetTranslation("Indiana.resoult.hasJoinCount",_data.buyTimes));
            if(_data.joinCount > 0)
            {
               _lookNumself.htmlText = LanguageMgr.GetTranslation("Indiana.resoult.checkSelfCodeII",_data.joinCount);
               _lookNumselfII.htmlText = LanguageMgr.GetTranslation("Indiana.resoult.checkSelfCode");
               _lookNumselfII.x = _lookNumself.textWidth + _lookNumself.x + 3;
            }
            else
            {
               _lookNumself.htmlText = LanguageMgr.GetTranslation("Indiana.infopanel.disIII");
               _lookNumselfII.htmlText = "";
            }
            _lookNum.htmlText = LanguageMgr.GetTranslation("Indiana.resoult.checkOtherCode",_data.useId);
         }
      }
      
      public function setInfo(param1:IndianaShopItemInfo) : void
      {
         _info = param1;
         setShowData();
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         ObjectUtils.disposeAllChildren(this);
         _luckBg = null;
         _luckNum = null;
         _nameitem = null;
         _severitem = null;
         _timesnumitem = null;
         _resoultitem = null;
         _lookNum = null;
         _lookNumself = null;
         _line = null;
      }
   }
}
