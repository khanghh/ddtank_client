package petsBag.petsAdvanced
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class PetsPropItem extends Sprite implements Disposeable
   {
       
      
      private var _propNameArr:Array;
      
      private var _propNameTxt:FilterFrameText;
      
      private var _propValueTxt:FilterFrameText;
      
      private var _risingStarAddedPropValueTxt:FilterFrameText;
      
      private var _evolutionAddedPropValueTxt:FilterFrameText;
      
      private var _viewType:int;
      
      private var _numMc:MovieClip;
      
      private var _isPlayComplete:Boolean = true;
      
      private var _propValue:int;
      
      private var _addedProValue:Number;
      
      private var _index:int;
      
      public function PetsPropItem(param1:int)
      {
         _propNameArr = ["MaxHp","attack","defence","agility","luck"];
         super();
         _viewType = param1;
         initView();
      }
      
      private function initView() : void
      {
         _propNameTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.advanced.propNameTxt");
         addChild(_propNameTxt);
         _propValueTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.advanced.propValueTxt");
         addChild(_propValueTxt);
         if(_viewType == 1)
         {
            _risingStarAddedPropValueTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.risingStar.addedPropValueTxt");
            addChild(_risingStarAddedPropValueTxt);
         }
         else
         {
            _evolutionAddedPropValueTxt = ComponentFactory.Instance.creatComponentByStylename("petsBag.evolution.addedPropValueTxt");
            addChild(_evolutionAddedPropValueTxt);
         }
      }
      
      public function setData(param1:int, param2:int, param3:Number) : void
      {
         _index = param1;
         _propValue = param2;
         _addedProValue = param3;
         if(!_isPlayComplete)
         {
            return;
         }
         _propNameTxt.text = LanguageMgr.GetTranslation(_propNameArr[param1]);
         if(_viewType == 1)
         {
            _propValueTxt.text = "+" + param2;
            _risingStarAddedPropValueTxt.text = "（+" + param3.toFixed(1) + "）";
         }
         else
         {
            _propValueTxt.text = "" + param2;
            _evolutionAddedPropValueTxt.text = "+" + int(param3);
         }
      }
      
      public function playNumMc() : void
      {
         var _loc1_:int = 0;
         if(_viewType == 1)
         {
            _loc1_ = _propValueTxt.text.length - 1;
         }
         else
         {
            _loc1_ = _propValueTxt.text.length;
         }
         _numMc = ComponentFactory.Instance.creat("petsBag.advanced.numMc" + _loc1_);
         _numMc.x = _propValueTxt.x + 13 + 4.5 * (5 - _loc1_);
         _numMc.y = _propValueTxt.y + 2;
         addChild(_numMc);
         _isPlayComplete = false;
         addEventListener("enterFrame",__enterHandler);
      }
      
      protected function __enterHandler(param1:Event) : void
      {
         if(_numMc.currentFrame >= 23)
         {
            _isPlayComplete = true;
            setData(_index,_propValue,_addedProValue);
            removeChild(_numMc);
            _numMc = null;
            removeEventListener("enterFrame",__enterHandler);
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_propNameTxt);
         _propNameTxt = null;
         ObjectUtils.disposeObject(_propValueTxt);
         _propValueTxt = null;
         ObjectUtils.disposeObject(_risingStarAddedPropValueTxt);
         _risingStarAddedPropValueTxt = null;
         ObjectUtils.disposeObject(_evolutionAddedPropValueTxt);
         _evolutionAddedPropValueTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
