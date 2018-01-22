package GodSyah
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class SyahItemContent extends Sprite
   {
       
      
      private var _leftBtn:BaseButton;
      
      private var _rightBtn:BaseButton;
      
      private var _cellVec:Vector.<SyahSelfCell>;
      
      private var _index:int = -1;
      
      private var _content:Sprite;
      
      private var _alphaArr:Array;
      
      private var _tip:ScaleBitmapImage;
      
      private var _txt:FilterFrameText;
      
      public function SyahItemContent()
      {
         _cellVec = new Vector.<SyahSelfCell>();
         super();
         _buildUI();
         _addEvent();
         showContent();
         _configEvent();
      }
      
      private function _buildUI() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _leftBtn = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahView.leftBtn");
         _rightBtn = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahView.rightBtn");
         _content = new Sprite();
         addChild(_leftBtn);
         addChild(_rightBtn);
         addChild(_content);
         var _loc3_:Vector.<SyahMode> = SyahManager.Instance.syahItemVec;
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("godSyah.syahview.syahselfcell");
            _loc1_.shineEnable = _loc3_[_loc2_].isHold && _loc3_[_loc2_].isValid;
            _loc1_.info = SyahManager.Instance.cellItems[_loc2_];
            _cellVec.push(_loc1_);
            _loc2_++;
         }
         if(_cellVec.length < 7)
         {
            _leftBtn.visible = false;
            _rightBtn.visible = false;
         }
      }
      
      private function _addEvent() : void
      {
         _leftBtn.addEventListener("click",__changeItem);
         _rightBtn.addEventListener("click",__changeItem);
      }
      
      private function __changeItem(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:* = param1.target;
         if(_leftBtn !== _loc6_)
         {
            if(_rightBtn === _loc6_)
            {
               if(_index + 1 != _cellVec.length)
               {
                  _removeAllChild();
                  _loc4_ = _index - 4;
                  _loc2_ = 0;
                  while(_loc2_ < 6)
                  {
                     _content.addChild(_cellVec[_loc4_]);
                     _cellVec[_loc4_].x = 4 + _loc2_ * 57;
                     _cellVec[_loc4_].y = 4;
                     if(SyahManager.Instance.getSyahModeByInfo(_cellVec[_loc4_].info).isHold == false)
                     {
                        _alphaArr[_loc2_].visible = true;
                        _alphaArr[_loc2_].ishold = false;
                     }
                     else if(SyahManager.Instance.getSyahModeByInfo(_cellVec[_loc4_].info).isValid == false)
                     {
                        _alphaArr[_loc2_].visible = true;
                        _alphaArr[_loc2_].isvalid = false;
                     }
                     else
                     {
                        _alphaArr[_loc2_].visible = false;
                     }
                     _loc4_++;
                     _loc2_++;
                     _loc2_;
                  }
                  _index = Number(_index) + 1;
               }
            }
         }
         else if(_index > 5)
         {
            _removeAllChild();
            _loc3_ = _index - 6;
            _loc5_ = 0;
            while(_loc5_ < 6)
            {
               _content.addChild(_cellVec[_loc3_]);
               _cellVec[_loc3_].x = 4 + _loc5_ * 57;
               _cellVec[_loc3_].y = 4;
               if(SyahManager.Instance.getSyahModeByInfo(_cellVec[_loc3_].info).isHold == false)
               {
                  _alphaArr[_loc5_].visible = true;
                  _alphaArr[_loc5_].ishold = false;
               }
               else if(SyahManager.Instance.getSyahModeByInfo(_cellVec[_loc3_].info).isValid == false)
               {
                  _alphaArr[_loc5_].visible = true;
                  _alphaArr[_loc5_].isvalid = false;
               }
               else
               {
                  _alphaArr[_loc5_].visible = false;
               }
               _loc3_++;
               _loc5_++;
               _loc5_;
            }
            _index = Number(_index) - 1;
         }
      }
      
      public function showContent() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _alphaArr = [];
         _loc2_ = 0;
         while(_loc2_ < _cellVec.length)
         {
            if(_index >= 5)
            {
               return;
            }
            _content.addChild(_cellVec[_loc2_]);
            _cellVec[_loc2_].x = 4 + _loc2_ * 57;
            _cellVec[_loc2_].y = 4;
            _index = Number(_index) + 1;
            _loc1_ = new MovieClip();
            _loc1_.graphics.beginFill(16711680,0);
            _loc1_.graphics.drawRect(0,0,47,47);
            _loc1_.graphics.endFill();
            addChild(_loc1_);
            _loc1_.visible = false;
            _loc1_.x = 3 + _loc2_ * 57;
            _loc1_.y = 3;
            _alphaArr[_loc2_] = _loc1_;
            var _loc3_:Boolean = true;
            _loc1_.isvalid = _loc3_;
            _loc1_.ishold = _loc3_;
            if(SyahManager.Instance.getSyahModeByInfo(_cellVec[_loc2_].info).isHold == false)
            {
               _loc1_.visible = true;
               _loc1_.ishold = false;
            }
            else if(SyahManager.Instance.getSyahModeByInfo(_cellVec[_loc2_].info).isValid == false)
            {
               _loc1_.visible = true;
               _loc1_.isvalid = false;
            }
            _loc2_++;
         }
      }
      
      private function _configEvent() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _alphaArr.length)
         {
            _alphaArr[_loc1_].addEventListener("mouseOver",__overAlphaArea);
            _alphaArr[_loc1_].addEventListener("mouseOut",__outAlphaArea);
            _loc1_++;
         }
      }
      
      private function __overAlphaArea(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         if(_tip == null)
         {
            _tip = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipBg");
         }
         if(_txt == null)
         {
            _txt = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahview.tip.txt");
         }
         if(_loc2_.ishold == false)
         {
            _txt.text = LanguageMgr.GetTranslation("ddt.GodSyah.syahview.tiptext1");
         }
         else if(_loc2_.isvalid == false)
         {
            _txt.text = LanguageMgr.GetTranslation("ddt.GodSyah.syahview.tiptext2");
         }
         _txt.x = 10;
         _txt.y = 10;
         _tip.width = _txt.width + 10;
         _tip.height = _txt.height + 20;
         _tip.x = _loc2_.x + _loc2_.width / 2 - _tip.width / 2;
         _tip.y = _loc2_.y - _tip.height - 10;
         _tip.addChild(_txt);
         addChild(_tip);
      }
      
      private function __outAlphaArea(param1:MouseEvent) : void
      {
         if(_tip)
         {
            _txt.text = "";
            _txt = null;
            removeChild(_tip);
            _tip = null;
         }
      }
      
      private function _removeAllChild() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _content.numChildren)
         {
            _content.removeChildAt(0);
            _loc1_++;
         }
      }
      
      public function dispose() : void
      {
         if(_leftBtn)
         {
            ObjectUtils.disposeObject(_leftBtn);
            _leftBtn = null;
         }
         if(_rightBtn)
         {
            ObjectUtils.disposeObject(_rightBtn);
            _rightBtn = null;
         }
         if(_content)
         {
            ObjectUtils.disposeObject(_content);
            _content = null;
         }
         if(_tip)
         {
            ObjectUtils.disposeObject(_tip);
            _tip = null;
         }
         if(_txt)
         {
            ObjectUtils.disposeObject(_txt);
            _txt = null;
         }
      }
   }
}
