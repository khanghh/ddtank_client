package catchInsect.componets
{
   import catchInsect.data.CatchInsectRankInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextFormat;
   import newTitle.NewTitleManager;
   import vip.VipController;
   
   public class CatchInsectRankCell extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleFrameImage;
      
      private var _sprite:Sprite;
      
      private var _topThreeIcon:ScaleFrameImage;
      
      private var _placeTxt:FilterFrameText;
      
      private var _vipName:GradientText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _numTxt:FilterFrameText;
      
      private var _titleName:MovieClip;
      
      private var _zoneTxt:FilterFrameText;
      
      private var _titleTouch:Component;
      
      private var _info:CatchInsectRankInfo;
      
      private var _type:int;
      
      public function CatchInsectRankCell(param1:int)
      {
         _type = param1;
         super();
         initView();
      }
      
      private function initView() : void
      {
         _topThreeIcon = ComponentFactory.Instance.creatComponentByStylename("catchInsect.topThree");
         _topThreeIcon.visible = false;
         _placeTxt = ComponentFactory.Instance.creatComponentByStylename("catchInsect.placeTxt");
         _placeTxt.text = "4th";
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("catchInsect.nameTxt");
         _nameTxt.text = "小妹也带刀";
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("catchInsect.numTxt");
         _numTxt.text = "10000";
         switch(int(_type))
         {
            case 0:
               _bg = ComponentFactory.Instance.creatComponentByStylename("catchInsect.selfZoneCellBg");
               break;
            case 1:
               PositionUtils.setPos(_nameTxt,"catchInsect.nameTxtPos");
               PositionUtils.setPos(_numTxt,"catchInsect.numTxtPos");
               _bg = ComponentFactory.Instance.creatComponentByStylename("catchInsect.crossZoneCellBg");
               _zoneTxt = ComponentFactory.Instance.creatComponentByStylename("catchInsect.zoneTxt");
               _zoneTxt.text = "七道142区";
         }
         addChild(_bg);
         addChild(_topThreeIcon);
         addChild(_placeTxt);
         addChild(_nameTxt);
         addChild(_numTxt);
         if(_zoneTxt)
         {
            addChild(_zoneTxt);
         }
      }
      
      public function setData(param1:CatchInsectRankInfo) : void
      {
         _info = param1;
         _bg.setFrame(_info.place % 2 + 1);
         if(_info.titleNum)
         {
            _titleName = ComponentFactory.Instance.creat("catchInsect.title" + _info.titleNum);
            _titleName.scaleX = 0.7;
            _titleName.scaleY = 0.7;
            switch(int(_type))
            {
               case 0:
                  PositionUtils.setPos(_titleName,"catchInsect.titleNamePos");
                  break;
               case 1:
                  PositionUtils.setPos(_titleName,"catchInsect.titleNamePos1");
            }
            addChild(_titleName);
            _titleTouch = new Component();
            _titleTouch.graphics.beginFill(0,0);
            _titleTouch.graphics.drawRect(0,0,_titleName.width,_titleName.height);
            _titleTouch.graphics.endFill();
            _titleTouch.x = _titleName.x - _titleName.width / 2;
            _titleTouch.y = _titleName.y - _titleName.height;
            _titleTouch.width = _titleTouch.displayWidth;
            _titleTouch.height = _titleTouch.displayHeight;
            addChild(_titleTouch);
            _titleTouch.tipStyle = "catchInsect.componets.InsectTitleTip";
            _titleTouch.tipDirctions = "2";
            _titleTouch.tipData = NewTitleManager.instance.titleInfo[_info.titleNum];
         }
         setRankNum(_info.place);
         addNickName();
         _numTxt.text = _info.score.toString();
         if(_info.area && _zoneTxt)
         {
            _zoneTxt.text = _info.area;
         }
      }
      
      private function setRankNum(param1:int) : void
      {
         if(param1 <= 3)
         {
            _placeTxt.visible = false;
            _topThreeIcon.visible = true;
            _topThreeIcon.setFrame(param1);
         }
         else
         {
            _placeTxt.visible = true;
            _topThreeIcon.visible = false;
            _placeTxt.text = param1 + "th";
         }
      }
      
      private function addNickName() : void
      {
         var _loc1_:* = null;
         if(_vipName)
         {
            _vipName.dispose();
            _vipName = null;
         }
         _nameTxt.visible = !_info.isVIP;
         if(_info.isVIP)
         {
            _vipName = VipController.instance.getVipNameTxt(1,1);
            _loc1_ = new TextFormat();
            _loc1_.align = "center";
            _loc1_.bold = true;
            _vipName.textField.defaultTextFormat = _loc1_;
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
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeObject(_placeTxt);
         _placeTxt = null;
         ObjectUtils.disposeObject(_titleName);
         _titleName = null;
         ObjectUtils.disposeObject(_topThreeIcon);
         _topThreeIcon = null;
         ObjectUtils.disposeObject(_vipName);
         _vipName = null;
         ObjectUtils.disposeObject(_zoneTxt);
         _zoneTxt = null;
         ObjectUtils.disposeObject(_titleTouch);
         _titleTouch = null;
         ObjectUtils.disposeObject(_sprite);
         _sprite = null;
      }
   }
}
