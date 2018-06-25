package gameCommon.view
{
    import com.pickgliss.ui.ComponentFactory;
    import com.pickgliss.ui.core.Disposeable;
    import com.pickgliss.ui.text.FilterFrameText;
    import com.pickgliss.utils.ObjectUtils;
    import ddt.utils.PositionUtils;
    import flash.display.Sprite;

    public class DreamLandLogBaseView extends Sprite implements Disposeable
    {

        protected static const ITEM_COUNT:int = 4;


        protected var _titleTxt:FilterFrameText;

        protected var _nameVec:Vector.<FilterFrameText>;

        protected var _valueVec:Vector.<FilterFrameText>;

        protected var _infoSprite:Sprite;

        public function DreamLandLogBaseView()
        {
            super();
            _infoSprite = new Sprite();
            addChild(_infoSprite);
            initView();
        }

        protected function initView() : void
        {
            var i:int = 0;
            var name:* = null;
            var value:* = null;
            _nameVec = new Vector.<FilterFrameText>();
            _valueVec = new Vector.<FilterFrameText>();
            PositionUtils.setPos(_infoSprite,"asset.game.damageView.SpritePos");
            _titleTxt = ComponentFactory.Instance.creatComponentByStylename("game.view.damageView.listTxt");
            _infoSprite.addChild(_titleTxt);
            for(i = 0; i < 4; )
            {
                name = ComponentFactory.Instance.creatComponentByStylename("game.view.damageView.userInfo");
                PositionUtils.setPos(name,"game.view.damageView.userNamePos" + i);
                _nameVec.push(name);
                _infoSprite.addChild(name);
                value = ComponentFactory.Instance.creatComponentByStylename("game.view.damageView.userInfo");
                PositionUtils.setPos(value,"game.view.damageView.damageNumPos" + i);
                _valueVec.push(value);
                _infoSprite.addChild(value);
                i++;
            }
        }

        public function updateView(hurts:Array) : void
        {
            clearTextInfo();
        }

        private function clearTextInfo() : void
        {
            var i:int = 0;
            for(i = 0; i < _nameVec.length; )
            {
                _nameVec[i].text = "";
                _valueVec[i].text = "";
                i++;
            }
        }

        public function dispose() : void
        {
            while(_nameVec.length > 0)
            {
                ObjectUtils.disposeObject(_nameVec.shift());
            }
            _nameVec = null;
            while(_valueVec.length > 0)
            {
                ObjectUtils.disposeObject(_valueVec.shift());
            }
            _valueVec = null;
            _infoSprite = null;
            if(parent)
            {
                parent.removeChild(parent);
            }
        }
    }
}
