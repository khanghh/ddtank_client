package bombKing.components
{
   import bombKing.data.BKingRankInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import vip.VipController;
   
   public class BKingRankItem extends Sprite implements Disposeable
   {
       
      
      private var _sprite:Sprite;
      
      private var _backOverImg:Scale9CornerImage;
      
      private var _topThreeIcon:ScaleFrameImage;
      
      private var _placeTxt:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _areaName:FilterFrameText;
      
      private var _numTxt:FilterFrameText;
      
      private var _info:BKingRankInfo;
      
      public function BKingRankItem()
      {
         super();
         initView();
         addEvents();
      }
      
      private function initView() : void
      {
         _backOverImg = ComponentFactory.Instance.creatComponentByStylename("bombKing.rankFrame.mouseOver");
         _backOverImg.visible = false;
         _sprite = new Sprite();
         _sprite.graphics.beginFill(0,0);
         _sprite.graphics.drawRect(0,0,_backOverImg.width,_backOverImg.height);
         _sprite.graphics.endFill();
         _sprite.x = _backOverImg.x;
         _sprite.y = _backOverImg.y;
         addChild(_sprite);
         _topThreeIcon = ComponentFactory.Instance.creatComponentByStylename("bombKing.topThree");
         addChild(_topThreeIcon);
         _topThreeIcon.visible = false;
         _placeTxt = ComponentFactory.Instance.creatComponentByStylename("bombKing.rankVeiw.placeTxt");
         addChild(_placeTxt);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("bombKing.rankVeiw.nameTxt");
         addChild(_nameTxt);
         _areaName = ComponentFactory.Instance.creatComponentByStylename("bombKing.rankVeiw.areaName");
         addChild(_areaName);
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("bombKing.rankVeiw.numTxt");
         addChild(_numTxt);
         addChild(_backOverImg);
      }
      
      private function addEvents() : void
      {
         addEventListener("rollOver",__onOverHanlder);
         addEventListener("rollOut",__onOutHandler);
      }
      
      protected function __onOutHandler(event:MouseEvent) : void
      {
         _backOverImg.visible = false;
      }
      
      protected function __onOverHanlder(event:MouseEvent) : void
      {
         _backOverImg.visible = true;
      }
      
      public function set info(info:BKingRankInfo) : void
      {
         _info = info;
         setRankNum(_info.place);
         addNickName();
         _areaName.text = _info.areaName;
         _numTxt.text = _info.num + "";
      }
      
      private function addNickName() : void
      {
         var textFormat:* = null;
         if(_vipName)
         {
            _vipName.dispose();
            _vipName = null;
         }
         _nameTxt.visible = !_info.isVIP;
         if(_info.isVIP)
         {
            _vipName = VipController.instance.getVipNameTxt(1,1);
            textFormat = new TextFormat();
            textFormat.align = "center";
            textFormat.bold = true;
            _vipName.textField.defaultTextFormat = textFormat;
            _vipName.textSize = 16;
            _vipName.textField.width = _nameTxt.width;
            _vipName.x = _nameTxt.x;
            _vipName.y = _nameTxt.y;
            _vipName.text = _info.name;
            addChild(_vipName);
         }
         else
         {
            _nameTxt.text = _info.name;
         }
      }
      
      private function setRankNum(num:int) : void
      {
         if(num <= 3)
         {
            _placeTxt.visible = false;
            _topThreeIcon.visible = true;
            _topThreeIcon.setFrame(num);
         }
         else
         {
            _placeTxt.visible = true;
            _topThreeIcon.visible = false;
            _placeTxt.text = num + "th";
         }
      }
      
      private function removeEvents() : void
      {
         removeEventListener("rollOver",__onOverHanlder);
         removeEventListener("rollOut",__onOutHandler);
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeObject(_sprite);
         _sprite = null;
         ObjectUtils.disposeObject(_backOverImg);
         _backOverImg = null;
         ObjectUtils.disposeObject(_placeTxt);
         _placeTxt = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_areaName);
         _areaName = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeObject(_topThreeIcon);
         _topThreeIcon = null;
         ObjectUtils.disposeObject(_vipName);
         _vipName = null;
      }
   }
}
