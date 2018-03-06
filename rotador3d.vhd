--- Ver si tengo que descomentar todo
-- use ieee.std_logic_1164.all;
-- use ieee.numeric_std.all;
-- use ieee_proposed.fixed_float_types.all;
-- use ieee_proposed.fixed_pkg.all;
use ieee_proposed.float_pkg.all;

library work;
use work.cordic_lib.all;

entity rotador3d is
    generic(
		N: integer:= 32
	);
	port(
        pos: in t_coordenada;  -- Posición de un píxel a rotar a la pos correcta
		alfa, beta, gama: in t_float  -- Ángulo de rotación en x, y, z
	);
end;

architecture rotador3d_arq of rotador3d is
    variable aux_1, aux_2, aux_3: t_pos;
    variable pix: t_vec;

begin
    --for pos in posiciones loop  -- Mover cada píxel a la posición rotada

    -- Rotación en x
    aux_1(3) <= pos(1);
    if (alfa /= 0) then
    --if (not isZero(alfa)) then ---implementar en PF
        aux_1(1 to 2) <= cordic(pos(2 to 3), alfa);
    else
        aux_1(1 to 2) <= pos(2 to 3);
    end if;

    -- Rotación en y
    aux_2(3) <= aux_1(1);
    if (beta /= 0) then
    --if (not isZero(beta)) then
        aux_2(1 to 2) <= cordic(aux_1(2 to 3), beta);
    else
        aux_2(1 to 2) <= aux_1(2 to 3);
    end if;

    -- Rotación en z
    aux_3(3) <= aux_2(1);
    if (gama /= 0) then
    --if (not isZero(gama)) then
        aux_3(1 to 2) <= cordic(aux_2(2 to 3), gama);
    else
        aux_3(1 to 2) <= aux_2(2 to 3);
    end if;

    -- Aplana a ejes (y,z)
    pix <= aux(2 to 3);

    gen_dir: entity work.gen_dirs
		port map(
			pos => pix
		);

    --end loop;
end;