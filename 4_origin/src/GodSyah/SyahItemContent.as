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
         var i:int = 0;
         var cell:* = null;
         _leftBtn = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahView.leftBtn");
         _rightBtn = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahView.rightBtn");
         _content = new Sprite();
         addChild(_leftBtn);
         addChild(_rightBtn);
         addChild(_content);
         var vec:Vector.<SyahMode> = SyahManager.Instance.syahItemVec;
         for(i = 0; i < vec.length; )
         {
            cell = ComponentFactory.Instance.creatCustomObject("godSyah.syahview.syahselfcell");
            cell.shineEnable = vec[i].isHold && vec[i].isValid;
            cell.info = SyahManager.Instance.cellItems[i];
            _cellVec.push(cell);
            i++;
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
      
      private function __changeItem(e:MouseEvent) : void
      {
         var j:int = 0;
         var i:int = 0;
         var k:int = 0;
         var l:int = 0;
         var _loc6_:* = e.target;
         if(_leftBtn !== _loc6_)
         {
            if(_rightBtn === _loc6_)
            {
               if(_index + 1 != _cellVec.length)
               {
                  _removeAllChild();
                  for(k = _index - 4,l = 0; l < 6; )
                  {
                     _content.addChild(_cellVec[k]);
                     _cellVec[k].x = 4 + l * 57;
                     _cellVec[k].y = 4;
                     if(SyahManager.Instance.getSyahModeByInfo(_cellVec[k].info).isHold == false)
                     {
                        _alphaArr[l].visible = true;
                        _alphaArr[l].ishold = false;
                     }
                     else if(SyahManager.Instance.getSyahModeByInfo(_cellVec[k].info).isValid == false)
                     {
                        _alphaArr[l].visible = true;
                        _alphaArr[l].isvalid = false;
                     }
                     else
                     {
                        _alphaArr[l].visible = false;
                     }
                     k++;
                     l++;
                     l;
                  }
                  _index = Number(_index) + 1;
               }
            }
         }
         else if(_index > 5)
         {
            _removeAllChild();
            for(j = _index - 6,i = 0; i < 6; )
            {
               _content.addChild(_cellVec[j]);
               _cellVec[j].x = 4 + i * 57;
               _cellVec[j].y = 4;
               if(SyahManager.Instance.getSyahModeByInfo(_cellVec[j].info).isHold == false)
               {
                  _alphaArr[i].visible = true;
                  _alphaArr[i].ishold = false;
               }
               else if(SyahManager.Instance.getSyahModeByInfo(_cellVec[j].info).isValid == false)
               {
                  _alphaArr[i].visible = true;
                  _alphaArr[i].isvalid = false;
               }
               else
               {
                  _alphaArr[i].visible = false;
               }
               j++;
               i++;
               i;
            }
            _index = Number(_index) - 1;
         }
      }
      
      public function showContent() : void
      {
         var j:int = 0;
         var sp:* = null;
         _alphaArr = [];
         for(j = 0; j < _cellVec.length; )
         {
            if(_index >= 5)
            {
               return;
            }
            _content.addChild(_cellVec[j]);
            _cellVec[j].x = 4 + j * 57;
            _cellVec[j].y = 4;
            _index = Number(_index) + 1;
            sp = new MovieClip();
            sp.graphics.beginFill(16711680,0);
            sp.graphics.drawRect(0,0,47,47);
            sp.graphics.endFill();
            addChild(sp);
            sp.visible = false;
            sp.x = 3 + j * 57;
            sp.y = 3;
            _alphaArr[j] = sp;
            var _loc3_:Boolean = true;
            sp.isvalid = _loc3_;
            sp.ishold = _loc3_;
            if(SyahManager.Instance.getSyahModeByInfo(_cellVec[j].info).isHold == false)
            {
               sp.visible = true;
               sp.ishold = false;
            }
            else if(SyahManager.Instance.getSyahModeByInfo(_cellVec[j].info).isValid == false)
            {
               sp.visible = true;
               sp.isvalid = false;
            }
            j++;
         }
      }
      
      private function _configEvent() : void
      {
         var i:int = 0;
         for(i = 0; i < _alphaArr.length; )
         {
            _alphaArr[i].addEventListener("mouseOver",__overAlphaArea);
            _alphaArr[i].addEventListener("mouseOut",__outAlphaArea);
            i++;
         }
      }
      
      private function __overAlphaArea(e:MouseEvent) : void
      {
         var sp:MovieClip = e.target as MovieClip;
         if(_tip == null)
         {
            _tip = ComponentFactory.Instance.creatComponentByStylename("core.GoodsTipBg");
         }
         if(_txt == null)
         {
            _txt = ComponentFactory.Instance.creatComponentByStylename("GodSyah.syahview.tip.txt");
         }
         if(sp.ishold == false)
         {
            _txt.text = LanguageMgr.GetTranslation("ddt.GodSyah.syahview.tiptext1");
         }
         else if(sp.isvalid == false)
         {
            _txt.text = LanguageMgr.GetTranslation("ddt.GodSyah.syahview.tiptext2");
         }
         _txt.x = 10;
         _txt.y = 10;
         _tip.width = _txt.width + 10;
         _tip.height = _txt.height + 20;
         _tip.x = sp.x + sp.width / 2 - _tip.width / 2;
         _tip.y = sp.y - _tip.height - 10;
         _tip.addChild(_txt);
         addChild(_tip);
      }
      
      private function __outAlphaArea(e:MouseEvent) : void
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
         var i:int = 0;
         for(i = 0; i < _content.numChildren; )
         {
            _content.removeChildAt(0);
            i++;
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
