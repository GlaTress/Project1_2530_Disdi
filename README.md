
## Síntesis en DE0
1. Crear proyecto en Quartus (familia Cyclone III, dispositivo DE0).
2. Añadir fuentes de `/src` y definir **FirstProject** como entidad tope.
3. Asignar pines a **SW**, **HEX** y reloj/enable según la hoja de datos de la DE0 (usar Pin Planner).
4. Compilar y programar vía **USB-Blaster**.

## Simulación
- Preparar `tb_FirstProject.vhd` con estímulos para:
  - Suma, resta y multiplicación (por ejemplo: 5+7=12, 9−3=6, 9×9=81).
  - Casos de signo en suma/resta (valor absoluto activo).
  - Umbral de visualización (A OR B > 9).
  - Fuera de rango (muestra **E**).
- Ejecutar en ModelSim/Questa y capturar formas de onda.

## Pruebas de funcionamiento (resumen)
- **Salida de Arithmetic Unit**: valida modos de SelOp y normalización a 8 bits.
- **Salida del proyecto con valor absoluto**: negativos → magnitud positiva; no negativos → paso directo.
- **Salida de Bin2BCD**: decenas y unidades correctas para 0–81.
- **7 segmentos**: patrones correctos de dígitos, símbolo y **E** en error.

## Ejemplos
- 8 × 9 → 72 → decenas=7, unidades=2; displays muestran 7 y 2.
- 3 − 9 → −6 → valor absoluto 6; regla de umbral decide si se ve signo o decenas.
- Entrada >9 en cualquiera de los operandos → ambos displays muestran **E**.

## Implementación
- Plataforma: **DE0**.
- Lenguaje: **VHDL**.
- Se adjunta enlace al repositorio y proyecto de síntesis (añadir aquí el URL).


## Autores
Thomas Leal Puerta, Francisco Alejandro Quiroga Boshell
